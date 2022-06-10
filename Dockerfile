# ========= BUILD =========
FROM node:alpine3.15 as builder

WORKDIR /app


COPY package.json .
COPY package-lock.json .
RUN npm install --omit=dev

COPY . .

RUN npm run build

# ========= RUN =========
FROM node:alpine3.15
WORKDIR /app
COPY --from=builder /app/build /app/build
COPY package.json .
RUN npm install serve
CMD [ "npm", "run", "serve"]