#!/bin/sh

git clone --branch master --depth 1 https://suhua:bc2f610b373b748137711a703a29de4a@gitee.com/suhua/pheditor.git 

cp /app/docker/nginx/nginx.conf /etc/nginx/nginx.conf
cp /app/docker/nginx/http.d/*.conf /etc/nginx/http.d/
cp /app/docker/nginx/stream.d/*.conf /etc/nginx/stream.d/

exec /usr/local/openresty/nginx/sbin/nginx -g "daemon off;"
