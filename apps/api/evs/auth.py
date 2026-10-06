"""OIDC bearer-token verification.

Locally the issuer is Keycloak; in GovCloud it is Cognito federated to Army ICAM.
Only the issuer URL and audience change. APEX authorization schemes map to the
`roles` claim checked by `require_role`.
"""

from collections.abc import Callable
from dataclasses import dataclass, field
from typing import Annotated

import httpx
import jwt
from fastapi import Depends, HTTPException, Request, status
from jwt import PyJWKClient

from evs.settings import Settings, get_settings


@dataclass
class Principal:
    subject: str
    name: str
    roles: list[str] = field(default_factory=list)


_jwks_clients: dict[str, PyJWKClient] = {}


def _jwks_client(issuer: str) -> PyJWKClient:
    if issuer not in _jwks_clients:
        conf = httpx.get(f"{issuer}/.well-known/openid-configuration", timeout=5).json()
        _jwks_clients[issuer] = PyJWKClient(conf["jwks_uri"])
    return _jwks_clients[issuer]


def current_principal(request: Request, settings: Annotated[Settings, Depends(get_settings)]) -> Principal:
    if settings.auth_disabled:
        return Principal(subject="dev", name="Demo User", roles=["evs_admin", "evs_viewer"])
    header = request.headers.get("authorization", "")
    if not header.lower().startswith("bearer "):
        raise HTTPException(status.HTTP_401_UNAUTHORIZED, "Missing bearer token")
    token = header.split(" ", 1)[1]
    try:
        key = _jwks_client(settings.oidc_issuer).get_signing_key_from_jwt(token).key
        claims = jwt.decode(
            token,
            key,
            algorithms=["RS256"],
            audience=settings.oidc_audience,
            issuer=settings.oidc_issuer,
        )
    except jwt.PyJWTError as exc:
        raise HTTPException(status.HTTP_401_UNAUTHORIZED, f"Invalid token: {exc}") from exc
    roles = claims.get("realm_access", {}).get("roles", []) or claims.get("cognito:groups", [])
    return Principal(subject=claims["sub"], name=claims.get("name", claims["sub"]), roles=roles)


def require_role(role: str) -> Callable[[Principal], Principal]:
    def dependency(principal: Annotated[Principal, Depends(current_principal)]) -> Principal:
        if role not in principal.roles:
            raise HTTPException(status.HTTP_403_FORBIDDEN, f"Requires role {role}")
        return principal

    return dependency
