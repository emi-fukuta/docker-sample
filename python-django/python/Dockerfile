FROM python:3.7.0-alpine3.7

RUN apk add --update --no-cache \
      build-base \
      linux-headers \
      pcre pcre-dev \
      libffi-dev \
      openssl-dev

RUN pip install \
      Django==2.1.1 \
      PyMySQL==0.9.2 \
      PyYaml==3.13 \
      django-allauth \
      django-cors-headers \
      django-cryptography \
      django-filter \
      django-kvstore \
      django-sendgrid-v5 \
      djangorestframework \
      djangorestframework-camel-case \
      redis \
      uwsgi

RUN apk add --update --no-cache tzdata \
 && cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
 && apk del tzdata

ENV APP_NAME=web_backend \
    ROOT_DIR=/var/www/app \
    SOCK_DIR=/var/run/uwsgi \
    CONF_DIR=docker/python \
    LOGS_DIR=/var/log/python \
    UWSGI_CONF_DIR=/etc/uwsgi/vassals

RUN mkdir -p ${ROOT_DIR}/${APP_NAME} ${SOCK_DIR} ${LOGS_DIR}

WORKDIR ${ROOT_DIR}
COPY ./${APP_NAME} ${APP_NAME}
COPY ./${CONF_DIR}/uwsgi/api.ini ${UWSGI_CONF_DIR}/api.ini

VOLUME ["${ROOT_DIR}", "${SOCK_DIR}"]
CMD ["uwsgi", "--ini", "/etc/uwsgi/vassals/api.ini"]

