"""OIDC bearer-token verification.

Locally the issuer is Keycloak; in GovCloud it is Cognito federated to Army ICAM.
Only the issuer URL and audience change. APEX authorization schemes map to the
`roles` claim checked by `require_role`:

| APEX scheme (Strategic Planner) | EVS role     | Used by                         |
|---------------------------------|--------------|---------------------------------|
| Authenticated User              | `evs_viewer` | every non-public GET            |
| Contributor                     | `evs_pm`     | POST/PUT on projects, milestones|
| Administrator                   | `evs_admin`  | `/admin/*`                      |
| (public pages, no scheme)       | none         | `/public/*`, `/health`          |

Roles are read from `realm_access.roles` (Keycloak) or `cognito:groups` (Cognito). `evs_admin`
implies `evs_pm` and `evs_viewer`; `evs_pm` implies `evs_viewer`.
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


APEX_SCHEME_TO_ROLE = {
    "Authenticated User": "evs_viewer",
    "Contributor": "evs_pm",
    "Administrator": "evs_admin",
}
ROLE_IMPLIES = {"evs_admin": {"evs_admin", "evs_pm", "evs_viewer"}, "evs_pm": {"evs_pm", "evs_viewer"}}

_jwks_clients: dict[str, PyJWKClient] = {}


def _jwks_client(settings: Settings) -> PyJWKClient:
    issuer = settings.oidc_issuer
    if issuer not in _jwks_clients:
        jwks_uri = settings.oidc_jwks_url
        if not jwks_uri:
            conf = httpx.get(f"{issuer}/.well-known/openid-configuration", timeout=5).json()
            jwks_uri = conf["jwks_uri"]
        _jwks_clients[issuer] = PyJWKClient(jwks_uri, cache_keys=True)
    return _jwks_clients[issuer]


def reset_jwks_cache() -> None:
    _jwks_clients.clear()


def effective_roles(roles: list[str]) -> set[str]:
    out: set[str] = set()
    for r in roles:
        out |= ROLE_IMPLIES.get(r, {r})
    return out


def current_principal(request: Request, settings: Annotated[Settings, Depends(get_settings)]) -> Principal:
    if settings.auth_disabled:
        return Principal(subject="dev", name="Demo User", roles=["evs_admin", "evs_viewer"])
    header = request.headers.get("authorization", "")
    if not header.lower().startswith("bearer "):
        raise HTTPException(
            status.HTTP_401_UNAUTHORIZED, "Missing bearer token", headers={"WWW-Authenticate": "Bearer"}
        )
    token = header.split(" ", 1)[1]
    try:
        key = _jwks_client(settings).get_signing_key_from_jwt(token).key
        claims = jwt.decode(
            token,
            key,
            algorithms=["RS256"],
            audience=settings.oidc_audience,
            issuer=settings.oidc_issuer,
        )
    except (jwt.PyJWTError, httpx.HTTPError) as exc:
        raise HTTPException(
            status.HTTP_401_UNAUTHORIZED, f"Invalid token: {exc}", headers={"WWW-Authenticate": "Bearer"}
        ) from exc
    roles = claims.get("realm_access", {}).get("roles", []) or claims.get("cognito:groups", []) or []
    return Principal(
        subject=claims["sub"],
        name=claims.get("name") or claims.get("preferred_username") or claims["sub"],
        roles=[r for r in roles if r.startswith("evs_")],
    )


def require_role(role: str) -> Callable[[Principal], Principal]:
    """Dependency factory. 401 without a valid token, 403 when `role` is not held or implied."""

    def dependency(principal: Annotated[Principal, Depends(current_principal)]) -> Principal:
        if role not in effective_roles(principal.roles):
            raise HTTPException(status.HTTP_403_FORBIDDEN, f"Requires role {role}")
        return principal

    dependency.__name__ = f"require_{role}"
    return dependency


require_viewer = require_role("evs_viewer")
require_pm = require_role("evs_pm")
require_admin = require_role("evs_admin")
