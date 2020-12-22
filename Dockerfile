FROM alpine:latest
LABEL maintainer="EduMelo <dev@edumelo.com.br>"
# webproc release settings
ENV WEBPROC_VERSION 0.4.0
ENV WEBPROC_URL https://www.github.com/jpillora/webproc/releases/download/v0.4.0/webproc_0.4.0_linux_arm7.gz
RUN apk update \
	&& apk --no-cache add tftp-hpa \
	&& apk add --no-cache --virtual .build-deps curl \
	&& curl -sL $WEBPROC_URL | gzip -d - > /usr/local/bin/webproc \
	&& chmod +x /usr/local/bin/webproc
EXPOSE 69/udp
ENTRYPOINT ["in.tftpd"]
CMD ["webproc","--config","/etc/default/tftpd-hpa","--","/var/tftpboot"]
