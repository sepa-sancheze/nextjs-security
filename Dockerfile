FROM node:24-alpine AS base

RUN apk add --no-cache libc6-compat

ENV PNPM_HOME=/pnpm
ENV PATH=$PNPM_HOME:$PATH

RUN corepack enable \
 && corepack prepare pnpm@10.13.1 --activate

WORKDIR /app

FROM base AS deps

COPY package.json pnpm-lock.yaml* ./

RUN pnpm install --frozen-lockfile

FROM base AS build

COPY --from=deps /app/node_modules ./node_modules
COPY . .

RUN pnpm build

FROM node:24-alpine AS runner

RUN apk add --no-cache libc6-compat

ENV NODE_ENV=production
ENV PORT=3000

WORKDIR /app

COPY --from=build --chown=node:node /app/public ./public
COPY --from=build --chown=node:node /app/.next/standalone ./standalone
COPY --from=build --chown=node:node /app/.next/static ./standalone/.next/static

USER node

EXPOSE 3000

CMD ["node", "standalone/server.js"]
