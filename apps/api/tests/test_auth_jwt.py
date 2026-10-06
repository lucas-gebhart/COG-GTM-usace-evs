"""Real JWT verification with EVS_AUTH_DISABLED=false.

A throwaway RSA key signs tokens; a fake JWKS (served from a local HTTP server) publishes the
public key. Proves issuer, audience, signature and role checks: 401 for missing, forged or
mis-issued tokens, 403 for a missing role, 200 when the APEX scheme maps to a held role.
"""

from __future__ import annotations

import json
import threading
import time
from collections.abc import Iterator
from http.server import BaseHTTPRequestHandler, HTTPServer

import jwt
import pytest
from cryptography.hazmat.primitives import serialization
from cryptography.hazmat.primitives.asymmetric import rsa
from jwt.algorithms import RSAAlgorithm

from evs.auth import reset_jwks_cache
from tests.conftest import make_client

ISSUER = "https://idp.test/realms/evs"
AUDIENCE = "evs-web"
KID = "test-key-1"


class _Keys:
    def __init__(self) -> None:
        self.good = rsa.generate_private_key(public_exponent=65537, key_size=2048)
        self.rogue = rsa.generate_private_key(public_exponent=65537, key_size=2048)
        pub = json.loads(RSAAlgorithm.to_jwk(self.good.public_key()))
        self.jwks = {"keys": [{**pub, "kid": KID, "use": "sig", "alg": "RS256"}]}

    def token(self, roles: list[str], key=None, **overrides) -> str:  # noqa: ANN001
        now = int(time.time())
        claims = {
            "iss": ISSUER,
            "aud": AUDIENCE,
            "sub": "u-123",
            "name": "Test PM",
            "iat": now,
            "exp": now + 300,
            "realm_access": {"roles": roles},
            **overrides,
        }
        pem = (key or self.good).private_bytes(
            serialization.Encoding.PEM, serialization.PrivateFormat.PKCS8, serialization.NoEncryption()
        )
        return jwt.encode(claims, pem, algorithm="RS256", headers={"kid": KID})


@pytest.fixture(scope="module")
def keys() -> Iterator[tuple[_Keys, str]]:
    k = _Keys()

    class Handler(BaseHTTPRequestHandler):
        def do_GET(self):  # noqa: N802
            body = json.dumps(k.jwks).encode()
            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.send_header("Content-Length", str(len(body)))
            self.end_headers()
            self.wfile.write(body)

        def log_message(self, *_):  # noqa: ANN002
            pass

    server = HTTPServer(("127.0.0.1", 0), Handler)
    thread = threading.Thread(target=server.serve_forever, daemon=True)
    thread.start()
    try:
        yield k, f"http://127.0.0.1:{server.server_port}/jwks"
    finally:
        server.shutdown()


@pytest.fixture
def secured(keys):
    reset_jwks_cache()
    yield from make_client(
        EVS_DATA_MODE="fixtures",
        EVS_AUTH_DISABLED="false",
        EVS_OIDC_ISSUER=ISSUER,
        EVS_OIDC_AUDIENCE=AUDIENCE,
        EVS_OIDC_JWKS_URL=keys[1],
    )
    reset_jwks_cache()


def _h(token: str) -> dict[str, str]:
    return {"Authorization": f"Bearer {token}"}


def test_401_without_or_with_bad_token(secured, keys):
    k, _ = keys
    assert secured.get("/api/v1/projects").status_code == 401
    assert secured.get("/api/v1/projects").headers["www-authenticate"] == "Bearer"
    assert secured.get("/api/v1/projects", headers=_h("not.a.jwt")).status_code == 401
    assert (
        secured.get("/api/v1/projects", headers=_h(k.token(["evs_viewer"], key=k.rogue))).status_code == 401
    )
    assert (
        secured.get("/api/v1/projects", headers=_h(k.token(["evs_viewer"], iss="https://evil"))).status_code
        == 401
    )
    assert (
        secured.get("/api/v1/projects", headers=_h(k.token(["evs_viewer"], aud="other"))).status_code == 401
    )
    expired = k.token(["evs_viewer"], exp=int(time.time()) - 10)
    assert secured.get("/api/v1/projects", headers=_h(expired)).status_code == 401


def test_public_needs_nothing(secured):
    assert secured.get("/api/v1/public/locks").status_code == 200
    assert secured.get("/api/v1/public/srp/coverage").status_code == 200
    assert secured.get("/api/v1/health").status_code == 200


def test_role_matrix(secured, keys):
    k, _ = keys
    viewer, pm, admin = (_h(k.token([r])) for r in ("evs_viewer", "evs_pm", "evs_admin"))
    no = secured.get("/api/v1/projects", headers=viewer).json()["items"][0]["p2_project_no"]
    body = {"pct_complete": 20}
    # Authenticated User -> read only
    assert secured.get(f"/api/v1/projects/{no}", headers=viewer).status_code == 200
    assert secured.put(f"/api/v1/projects/{no}/status", json=body, headers=viewer).status_code == 403
    assert secured.get("/api/v1/admin/thresholds", headers=viewer).status_code == 403
    # Contributor -> writes, no admin
    assert secured.put(f"/api/v1/projects/{no}/status", json=body, headers=pm).status_code == 200
    assert secured.get("/api/v1/admin/feeds", headers=pm).status_code == 403
    # Administrator -> everything
    assert secured.get("/api/v1/admin/feeds", headers=admin).status_code == 200
    assert secured.put(f"/api/v1/projects/{no}/status", json=body, headers=admin).status_code == 200
    # A token without any evs_ role is authenticated but not authorised
    assert secured.get("/api/v1/projects", headers=_h(k.token(["offline_access"]))).status_code == 403


def test_cognito_groups_claim_is_accepted(secured, keys):
    k, _ = keys
    tok = k.token([], **{"realm_access": {}, "cognito:groups": ["evs_admin"]})
    assert secured.get("/api/v1/admin/thresholds", headers=_h(tok)).status_code == 200
