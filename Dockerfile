# Base
FROM node:12-alpine as base

WORKDIR /app

# Dependencies
COPY package*.json ./
RUN npm install

# Build
WORKDIR /app
COPY . .
RUN npm run build

# App
FROM node:12-alpine as app

COPY --from=base /app/package*.json ./
RUN npm install --only=production
COPY --from=base /app/dist ./dist

USER node
ENV PORT=8080
EXPOSE 8080

CMD ["node", "dist/main.js"]
