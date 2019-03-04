FROM ruby:2.5.1-alpine3.7

RUN apk add --update --no-cache \
        build-base \
        libcurl \
        postgresql-dev \
        postgresql \
        linux-headers \
        libmcrypt-dev \
        sqlite-dev \
        nodejs \
        imagemagick6-dev \
        ffmpeg \
        redis

RUN mkdir -p /var/www/app

ENV ROOT_DIR=/var/www/app \
    RAILS_ENV=development

WORKDIR ${ROOT_DIR}
COPY Gemfile ${ROOT_DIR}/Gemfile
COPY Gemfile.lock ${ROOT_DIR}/Gemfile.lock
RUN  bundle install --path=../shared/vendor/bundle --jobs=4
ADD  . ${ROOT_DIR}

EXPOSE 3000

VOLUME ["${ROOT_DIR}"]
CMD ["bundle", "exec", "pumactl", "start"]

