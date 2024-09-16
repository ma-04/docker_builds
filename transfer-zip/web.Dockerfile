FROM bitnami/git AS gitloader
RUN git clone https://github.com/robinkarlberg/transfer.zip-web transfer -b main --depth=1

FROM node:alpine3.19 AS build

WORKDIR /app
COPY --from=gitloader /transfer/web-server/ /app

COPY --from=gitloader /transfer/web-server/example.env .env
# COPY . .
RUN ls -alh && sleep 10
# RUN ls -alh && sleep 10
RUN npm i
RUN npm run build

FROM nginx:alpine AS serve

COPY --from=build /app/nginx.conf /etc/nginx/conf.d/nginx.conf
# ADD src/static /var/www/static
COPY --from=build /app/build /var/www/static
RUN rm /etc/nginx/conf.d/default.conf

#COPY --from=build /app/run-server.sh /usr/local/bin

COPY <<EOF /usr/local/bin/run-server.sh
#!/bin/sh
echo "Replacing App URL"
echo "  App Url: \$APP_URL"

replace_enpoints() {
  sed -i -e 's,APP_URL,'"\$APP_URL"',g' \$1
}
for jsfile in `find '/var/www/static' -type f -name '*.js'`
do
    replace_enpoints "\$jsfile"
done

nginx -g 'daemon off;' &

wait
EOF

RUN chmod +x /usr/local/bin/run-server.sh
EXPOSE 80

# USER root
CMD ["run-server.sh"]