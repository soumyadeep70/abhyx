# syntax=docker/dockerfile:1.7
ARG NODE_VERSION=20

# --- all deps (for build) ---
FROM node:${NODE_VERSION}-slim AS deps
WORKDIR /app
COPY package*.json ./
RUN --mount=type=cache,target=/root/.npm npm ci

# --- compile TypeScript ---
FROM deps AS build
COPY tsconfig.json ./
COPY src ./src
RUN npm run build

# --- production deps only ---
FROM node:${NODE_VERSION}-slim AS prod-deps
WORKDIR /app
ENV NODE_ENV=production
COPY package*.json ./
RUN --mount=type=cache,target=/root/.npm npm ci --omit=dev

# --- runtime ---
FROM node:${NODE_VERSION}-slim AS runtime
ENV NODE_ENV=production \
    PORT=8080

# tini = proper PID 1 (signal forwarding, zombie reaping) so shutdowns are clean
RUN apt-get update \
 && apt-get install -y --no-install-recommends tini \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY --chown=node:node package*.json ./
COPY --from=prod-deps --chown=node:node /app/node_modules ./node_modules
COPY --from=build --chown=node:node /app/dist ./dist
COPY --chown=node:node src/db/migrations ./dist/db/migrations
COPY --chown=node:node src/db/seeds ./dist/db/seeds
RUN mkdir -p uploads/resumes && chown -R node:node uploads

USER node
EXPOSE 8080

HEALTHCHECK --interval=10s --timeout=5s --start-period=15s --retries=6 \
  CMD ["node", "-e", "fetch('http://127.0.0.1:'+process.env.PORT+'/health').then(r=>process.exit(r.ok?0:1)).catch(()=>process.exit(1))"]

ENTRYPOINT ["tini", "--"]
CMD ["node", "dist/index.js"]