FROM nginx:1.13.12-alpine

ENV ROOT_DIR=/etc/nginx \
    CONF_DIR=docker/development/nginx

RUN  mkdir -p /var/www/html/biz
COPY ${CONF_DIR}/index.html /var/www/html/index.html

WORKDIR ${ROOT_DIR}
COPY ${CONF_DIR}/nginx.conf ${ROOT_DIR}/nginx.conf
RUN rm -f ${ROOT_DIR}/conf.d/*
COPY ${CONF_DIR}/conf.d ${ROOT_DIR}/conf.d

EXPOSE 80

