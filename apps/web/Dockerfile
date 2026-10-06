FROM node:22-alpine AS build
RUN corepack enable
WORKDIR /app
COPY packages/contract/openapi.json /packages/contract/openapi.json
COPY apps/web/package.json apps/web/pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile
COPY apps/web/ ./
RUN sed -i 's#../../packages/contract#/packages/contract#' package.json && pnpm gen:api && pnpm build

FROM nginx:1.27-alpine
COPY apps/web/nginx.conf.template /etc/nginx/templates/default.conf.template
COPY --from=build /app/dist /usr/share/nginx/html
ENV API_UPSTREAM=http://api:8000
EXPOSE 80
