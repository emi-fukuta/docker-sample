FROM nginx:1.13.12-alpine

ENV ROOT_DIR=/etc/nginx \
    CONF_DIR=docker/nginx

RUN mkdir -p /var/www/app

WORKDIR ${ROOT_DIR}
ADD ${CONF_DIR}/nginx.conf ${ROOT_DIR}/nginx.conf
ADD ${CONF_DIR}/conf.d ${ROOT_DIR}/conf.d

EXPOSE 80

