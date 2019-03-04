FROM nginx:1.15.1-alpine

RUN apk add --update --no-cache tzdata \
 && cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
 && apk del tzdata

ENV ROOT_DIR=/etc/nginx \
    CONF_DIR=docker/nginx

ARG app_env

RUN mkdir -p /var/www/app

WORKDIR ${ROOT_DIR}
ADD ${CONF_DIR}/nginx.conf nginx.conf
RUN rm -rf conf.d/*
ADD ${CONF_DIR}/conf.d conf.d
RUN mv conf.d/api.conf.${app_env} conf.d/api.conf \
 && rm -f conf.d/*.conf.*

EXPOSE 80

