FROM bitnami/git AS gitloader
RUN git clone https://github.com/robinkarlberg/transfer.zip-web transfer -b main --depth=1

FROM node:alpine3.19 AS run

WORKDIR /app
COPY --from=gitloader /transfer/signaling-server /app

COPY package.json package-lock.json ./

RUN npm i

COPY index.js ./

EXPOSE 8001

CMD ["npm", "start"]