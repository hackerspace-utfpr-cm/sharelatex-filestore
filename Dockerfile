FROM node:8.9.1 as app

COPY ./ /app

WORKDIR /app

RUN npm install

RUN npm run compile:all

FROM node:8.9.1

COPY --from=app /app /app

WORKDIR /app

# All app and node_modules will be owned by root.
# The app will run as the 'node' user, and so not have write permissions
# on any files it doesn't need.
RUN ./install_deps.sh

# USER node

CMD ["node","app.js"]
