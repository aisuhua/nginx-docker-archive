FROM alpine:3.14.1

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN apk add --no-cache lftp

USER 1001

ENTRYPOINT ["tail"]
CMD ["-f","/dev/null"]
