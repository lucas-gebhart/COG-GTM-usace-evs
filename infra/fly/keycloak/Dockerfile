# Keycloak 26 with the EVS realm baked in (same realm file as infra/compose/keycloak).
# Build context is the repo root: docker build -f infra/fly/keycloak/Dockerfile .
FROM quay.io/keycloak/keycloak:26.4
COPY infra/compose/keycloak/evs-realm.json /opt/keycloak/data/import/evs-realm.json
CMD ["start-dev", "--import-realm"]
