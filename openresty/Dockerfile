FROM alpine:3.14.1

RUN wget 'http://openresty.org/package/admin@openresty.com-5ea678a6.rsa.pub' \
        -O '/etc/apk/keys/admin@openresty.com-5ea678a6.rsa.pub' \
    && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && echo "http://openresty.org/package/alpine/v3.14/main" >> /etc/apk/repositories

RUN apk add --no-cache \
    openresty

RUN mkdir -p \
        /application \
        /usr/local/openresty/nginx/conf.d

COPY nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
COPY default.conf /usr/local/openresty/nginx/conf.d/default.conf
COPY index.html /application

RUN chown -R 0:0 \
        /application \
        /usr/local/openresty \
    && chmod -R 775 \
        /application \
        /usr/local/openresty \
    && ln -sf /dev/stdout /usr/local/openresty/nginx/logs/access.log \
    && ln -sf /dev/stderr /usr/local/openresty/nginx/logs/error.log

USER 1001

WORKDIR /application

EXPOSE 8080

CMD ["/usr/local/openresty/nginx/sbin/nginx", "-g", "daemon off;"]
