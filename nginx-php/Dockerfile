FROM alpine:3.14.1

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN apk add --no-cache tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# install base
RUN apk add --no-cache \
    bash \
    gettext \
    curl \
    vim

# install php
RUN apk add --no-cache \
    php7 \
    php7-curl \
    php7-dom \
    php7-fileinfo \
	php7-fpm \
	php7-gd \
	php7-gettext \
	php7-json \
	php7-mbstring \
	php7-openssl \
	php7-pdo \
	php7-phar \
	php7-psr \
	php7-opcache \
	php7-session \
	php7-simplexml \
	php7-tokenizer \
	php7-xml \
	php7-zlib \
    php7-bcmath \
    php7-zip \
    php7-mysqli \
    php7-soap \
    php7-ldap \
    php7-iconv \
    php7-pear \
    php7-pecl-imagick \
    php7-pecl-msgpack \
    php7-pecl-igbinary \
    php7-pecl-mongodb \
    php7-pecl-memcache \
    php7-pecl-memcached \
    php7-pecl-redis \
    php7-pecl-amqp \
    php7-phalcon \
    php7-pecl-xdebug

# install nginx
RUN apk add --no-cache \
    nginx \
    nginx-mod-http-image-filter

# install supervisor
RUN apk add --no-cache \
    supervisor

RUN mkdir /etc/supervisor.d
COPY supervisor.ini /etc/supervisor.d/ 

# install composer
RUN wget https://mirrors.aliyun.com/composer/composer.phar && \
mv composer.phar /usr/local/bin/composer && \
chmod 755 /usr/local/bin/composer && \
composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/

# setup vim
RUN echo -e "set tabstop=4\n\
set shiftwidth=4\n\
set autoindent\n\
set expandtab\n\
set softtabstop=0" >> /etc/vim/vimrc

RUN mkdir -p /www/web
WORKDIR /www/web

EXPOSE 80

CMD ["supervisord", "-n", "-c", "/etc/supervisord.conf"]

#ENTRYPOINT ["tail"]
#CMD ["-f","/dev/null"]
