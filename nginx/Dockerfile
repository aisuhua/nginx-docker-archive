FROM alpine:3.14.1

RUN printf "%s%s%s%s\n" \
        "@nginx " \
        "http://nginx.org/packages/alpine/v" \
        `egrep -o '^[0-9]+\.[0-9]+' /etc/alpine-release` \
        "/main" \
        | tee -a /etc/apk/repositories \
    && wget "https://nginx.org/keys/nginx_signing.rsa.pub" -O "/etc/apk/keys/nginx_signing.rsa.pub" \
    && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN apk add --no-cache \
    nginx \
    nginx-mod-http-image-filter

RUN mkdir -p \
        /app \
        /var/run/nginx \
        /var/cache/nginx \
        /var/lib/nginx  

COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf
COPY index.html /app

RUN chown -R 1001:0 \
        /app \
        /etc/nginx \
        /var/run/nginx \
        /var/cache/nginx \
        /var/lib/nginx \
    && chmod -R 775 \
        /app \
        /etc/nginx \
        /var/run/nginx \
        /var/cache/nginx \
        /var/lib/nginx \
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

USER 1001

WORKDIR /app

EXPOSE 8080

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
