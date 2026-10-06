# Build context is the repo root (Compose and Fly both use it): docker build -f apps/web/Dockerfile .
FROM node:22-alpine AS build
RUN corepack enable
WORKDIR /app
COPY packages/contract/openapi.json /packages/contract/openapi.json
COPY apps/web/package.json apps/web/pnpm-lock.yaml apps/web/pnpm-workspace.yaml ./
COPY apps/web/scripts/ ./scripts/
RUN pnpm install --frozen-lockfile
COPY apps/web/ ./
RUN sed -i 's#../../packages/contract#/packages/contract#' package.json && pnpm gen:api && pnpm build

# Basemap: Protomaps PMTiles extract (continental US, z0-z8, about 56 MB). Cached by Docker as long as the
# build args do not change. Skip with --build-arg FETCH_BASEMAP=false (the map then has no basemap).
FROM alpine:3.20 AS tiles
ARG FETCH_BASEMAP=true
ARG BASEMAP_BUILD=20261005
ARG BASEMAP_MAXZOOM=8
RUN apk add --no-cache curl
COPY tools/basemap/fetch.sh /fetch.sh
RUN mkdir -p /out && if [ "$FETCH_BASEMAP" = "true" ]; then \
      BASEMAP_BUILD=$BASEMAP_BUILD BASEMAP_MAXZOOM=$BASEMAP_MAXZOOM sh /fetch.sh /out/usace.pmtiles; \
    fi

FROM nginx:1.27-alpine
COPY apps/web/nginx.conf.template /etc/nginx/templates/default.conf.template
COPY --from=build /app/dist /usr/share/nginx/html
COPY --from=tiles /out/ /usr/share/nginx/html/tiles/
ENV API_UPSTREAM=http://api:8000 DNS_RESOLVER=127.0.0.11
EXPOSE 80
HEALTHCHECK --interval=15s --timeout=3s --start-period=5s --retries=5 CMD wget -qO- http://127.0.0.1/healthz >/dev/null || exit 1
