FROM php:7.2.6-fpm-alpine3.7

RUN apk update \
 && apk add --no-cache \
      rsync \
      make \
      gcc \
      libzip-dev \
      libc-dev \
      libpng-dev \
      autoconf \
      automake \
      nodejs

RUN docker-php-ext-configure \
      zip --with-libzip 

RUN docker-php-ext-install \
      zip \
      pdo \
      pdo_mysql

RUN npm cache clean --force \
 && npm install -g cross-env cross-spawn

ENV USER_ETC_DIR=/usr/local/etc \
    TMP_DIR=/tmp \
    FPM_USER=www-data \
    SOCK_DIR=/var/run/php-fpm \
    ROOT_DIR=/var/www/html/biz \
    CONF_DIR=docker/local/php-fpm/files \
    COMPOSER_ALLOW_SUPERUSER=1

COPY ${CONF_DIR}/php.ini ${USER_ETC_DIR}/php/php.ini
COPY ${CONF_DIR}/php-fpm/*.conf ${USER_ETC_DIR}/
RUN rm -f ${USER_ETC_DIR}/php-fpm.d/*
COPY ${CONF_DIR}/php-fpm/php-fpm.d/*.conf ${USER_ETC_DIR}/php-fpm.d/
RUN mkdir -p ${SOCK_DIR} && chown ${FPM_USER}:${FPM_USER} ${SOCK_DIR}

COPY composer.* ${TMP_DIR}/
WORKDIR ${TMP_DIR}
RUN php composer.phar install --no-scripts --no-autoloader

COPY package.* ${TMP_DIR}/
COPY webpack.mix.js ${TMP_DIR}/
COPY resources/assets ${TMP_DIR}/resources/assets
WORKDIR ${TMP_DIR}
RUN npm install --no-bin-links --no-optional --only=dev \
 && npm rebuild node-sass \
 && chmod -R +x node_modules \
 && npm run dev

WORKDIR ${ROOT_DIR}
COPY . ${ROOT_DIR}
RUN mv ${ROOT_DIR}/.env.development ${ROOT_DIR}/.env
RUN rsync -a ${TMP_DIR}/vendor ${ROOT_DIR}/ \
 && rsync -a ${TMP_DIR}/node_modules ${ROOT_DIR}/ 

RUN php composer.phar dump-autoload \
 && php artisan key:generate \
 && php artisan config:clear \
 && php artisan config:cache

VOLUME ["${ROOT_DIR}", "${SOCK_DIR}"]
CMD ["php-fpm", "--allow-to-run-as-root"]

