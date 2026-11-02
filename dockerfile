FROM node:20-alpine AS build
RUN apk update && apk upgrade
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .

FROM node:20-alpine
RUN apk update && apk upgrade
WORKDIR /app
COPY --from=build /app .
ENV PORT=80
USER node
EXPOSE 80
CMD ["npm", "start"]