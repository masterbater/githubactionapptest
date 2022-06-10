# ========= BUILD =========
FROM node:alpine3.15 as builder

WORKDIR /app


COPY package.json .
COPY package-lock.json .
RUN npm install --omit=dev

COPY . .

RUN npm run build

# ========= RUN =========
FROM caddy:2.5.1-alpine

COPY CaddyfileForImageOnly /etc/caddy/Caddyfile
COPY --from=builder /app/build /var/www/html