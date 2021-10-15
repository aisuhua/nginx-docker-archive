FROM alpine:3.14.1

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

#RUN apk add --no-cache tzdata \
#    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN apk add --no-cache \	
    openssh-server

RUN mkdir /opt/ssh \
	&& ssh-keygen -q -N "" -t dsa -f /opt/ssh/ssh_host_dsa_key \
	&& ssh-keygen -q -N "" -t rsa -b 4096 -f /opt/ssh/ssh_host_rsa_key \
	&& ssh-keygen -q -N "" -t ecdsa -f /opt/ssh/ssh_host_ecdsa_key \
	&& ssh-keygen -q -N "" -t ed25519 -f /opt/ssh/ssh_host_ed25519_key \
	&& ln -sf /dev/stdout /tmp/sshd.log

COPY sshd_config /opt/ssh/sshd_config
COPY authorized_keys /opt/ssh/authorized_keys


RUN adduser -S suhua -G root \
	&& echo "suhua:suhua123" | chpasswd \
	&& mkdir /home/suhua/.ssh \
	&& chown suhua /home/suhua/.ssh \
	&& chmod 700 /home/suhua/.ssh

COPY authorized_keys /home/suhua/.ssh/authorized_keys
RUN chown suhua /home/suhua/.ssh/authorized_keys \
	&& chmod 600 /home/suhua/.ssh/authorized_keys 

RUN chmod 600 /opt/ssh/* \
	&& chmod 664 /opt/ssh/sshd_config \
	&& chmod 600 /opt/ssh/authorized_keys \
	&& chown -R suhua:0 /opt/ssh/

USER suhua

WORKDIR /opt/ssh

EXPOSE 2022

ENTRYPOINT ["tail"]
CMD ["-f","/dev/null"]
