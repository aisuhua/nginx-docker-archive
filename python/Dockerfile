FROM alpine:3.14.1

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN apk add --no-cache tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN apk add --no-cache \
    python3 \
    py3-pip

RUN pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

RUN mkdir -p /www/web
WORKDIR /www/web

ENTRYPOINT ["tail"]
CMD ["-f","/dev/null"]
