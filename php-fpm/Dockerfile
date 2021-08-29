FROM alpine:3.14.1

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN apk add --no-cache \
	php8 \
	php8-fpm

RUN mkdir /app

COPY docker.conf /etc/php8/php-fpm.d/
COPY zz-docker.conf /etc/php8/php-fpm.d/
COPY demo.php /app/

RUN ln -s /usr/bin/php8 /usr/bin/php \
	&& ln -s /usr/sbin/php-fpm8 /usr/bin/php-fpm \
	&& sed -ie 's/user\ =\ nobody/;user\ =\ nobody/g' /etc/php8/php-fpm.d/www.conf \
	&& sed -ie 's/group\ =\ nobody/;group\ =\ nobody/g' /etc/php8/php-fpm.d/www.conf \
	&& chown 0:0 /app \
	&& chmod -R 775 /app


USER 1001

STOPSIGNAL SIGQUIT

EXPOSE 9000
CMD ["php-fpm"]
#ENTRYPOINT ["tail"]
#CMD ["-f","/dev/null"]
