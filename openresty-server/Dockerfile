FROM alpine:3.14.1

RUN wget 'http://openresty.org/package/admin@openresty.com-5ea678a6.rsa.pub' \
        -O '/etc/apk/keys/admin@openresty.com-5ea678a6.rsa.pub' \
    && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && echo "http://openresty.org/package/alpine/v3.14/main" >> /etc/apk/repositories

RUN apk add --no-cache \
    busybox-extras \
    curl \
    git

RUN apk add --no-cache \
    openresty

COPY openresty/lua_module /usr/local/openresty/lua_module
COPY openresty/lualib/zlib.so /usr/local/openresty/lualib/zlib.so

RUN chown -R 0:0 \
        /usr/local/openresty \
    && chmod -R 775 \
        /usr/local/openresty \
    && ln -sf /dev/stdout /usr/local/openresty/nginx/logs/access.log \
    && ln -sf /dev/stderr /usr/local/openresty/nginx/logs/error.log

# for local build
# COPY openresty/nginx/conf /usr/local/openresty/nginx/conf

USER 1001
WORKDIR /usr/local/openresty/nginx/conf
EXPOSE 8080

#CMD ["/usr/local/openresty/nginx/sbin/nginx", "-g", "daemon off;"]
