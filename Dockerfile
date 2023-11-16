FROM node:14.7-alpine
ARG version
ENV VER=${version}
ENV NODE_ENV=production

WORKDIR /opt/app
COPY ./index.js ./index.js
COPY ./package.json ./package.json