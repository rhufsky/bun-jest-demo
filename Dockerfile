FROM oven/bun:1.2.4 AS base

# Install dependencies stage

FROM base AS deps

WORKDIR /tmp/dev

COPY package.json bun.lockb ./
RUN bun install --frozen-lockfile

## Build stage

FROM base AS builder

WORKDIR /tmp/prod
COPY --from=deps /tmp/dev/node_modules ./node_modules
COPY . .

ENV NEXT_TELEMETRY_DISABLED=1

RUN bun run build

## Runner stage

FROM base AS runner
ENV NODE_ENV=production

WORKDIR /app

# Don't run production as root
RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nodejs

ENV NODE_ENV=production
ENV NEXT_TELEMETRY_DISABLED=1

COPY --from=builder --chown=nodejs:nodejs /tmp/prod/public ./public
RUN mkdir .next
RUN chown nodejs:nodejs .next

COPY --from=builder --chown=nodejs:nodejs /tmp/prod/package.json ./package.json
COPY --from=builder --chown=nodejs:nodejs /tmp/prod/.next/standalone ./
COPY --from=builder --chown=nodejs:nodejs /tmp/prod/.next/static ./.next/static

USER 0
RUN mkdir -p ./tmp && chown nodejs:nodejs ./tmp
USER nodejs

EXPOSE 3000
ENV PORT=3000
ENV HOSTNAME="0.0.0.0"

CMD ["bun", "run", "start:prod"]
