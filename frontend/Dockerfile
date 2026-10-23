# syntax=docker/dockerfile:1.7
ARG NODE_VERSION=20

FROM node:${NODE_VERSION}-alpine AS build
WORKDIR /app

COPY package*.json ./
RUN --mount=type=cache,target=/root/.npm npm ci

# Vite reads frontend/.env at build time (VITE_API_URL is inlined into the bundle)
COPY . .
RUN test -f .env || (echo "ERROR: frontend/.env is missing (copy .env.example)" >&2; exit 1)

COPY . .
RUN npm run build
RUN set -e; \
    for d in dist build out; do if [ -d "$d" ]; then mv "$d" /out; break; fi; done; \
    [ -d /out ] || { echo "ERROR: build produced no dist/, build/ or out/ directory." >&2; exit 1; }

# --- runtime: unprivileged nginx (non-root, listens on 8080) ---
FROM nginxinc/nginx-unprivileged:1.27-alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /out /usr/share/nginx/html

EXPOSE 8080
HEALTHCHECK --interval=10s --timeout=3s --start-period=5s --retries=5 \
  CMD wget -qO /dev/null http://127.0.0.1:8080/ || exit 1