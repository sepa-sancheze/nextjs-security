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

FROM nginx:1.29.4-alpine AS runner

RUN apk add --no-cache nodejs libc6-compat supervisor

ENV NODE_ENV=production
ENV PORT=3000
ENV HOSTNAME=0.0.0.0

WORKDIR /app

COPY --from=build --chown=nginx:nginx /app/public ./public
COPY --from=build --chown=nginx:nginx /app/.next/standalone ./standalone
COPY --from=build --chown=nginx:nginx /app/.next/static ./standalone/.next/static

COPY nginx/default.conf /etc/nginx/conf.d/default.conf

COPY nginx/supervisord.conf /etc/supervisord.conf

EXPOSE 80

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]