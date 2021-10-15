FROM alpine:3.14.1

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN mkdir /app

COPY ./app /app 

RUN chown -R 1001:1001 /app

USER 1001

WORKDIR /app

EXPOSE 8080

ENTRYPOINT ["tail"]
CMD ["-f","/dev/null"]
