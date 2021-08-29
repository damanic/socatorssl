FROM alpine:3.14
MAINTAINER MJMAN

RUN mkdir -p /etc/socatorssl
ADD ./tor-socat.sh /etc/socatorssl/tor-socat.sh
ADD ./torrc /etc/tor/torrc

RUN apk update \
	&& apk upgrade  \
	&& apk add tor socat \
	&& rm -rf /var/cache/apk/* \
	&& chmod +x /etc/socatorssl/tor-socat.sh

ENTRYPOINT ["/etc/socatorssl/tor-socat.sh"]
