FROM debian:10

MAINTAINER Hau Bui <buichihau98@gmail.com>

RUN apt-get update \
  && apt-get -y --quiet --force-yes upgrade curl iproute2 \
  && apt-get install -y --no-install-recommends ca-certificates gcc g++ make build-essential git iptables-dev libavfilter-dev \
  libevent-dev libpcap-dev libxmlrpc-core-c3-dev markdown \
  libjson-glib-dev default-libmysqlclient-dev libhiredis-dev libssl-dev \
  libcurl4-openssl-dev libavcodec-extra gperf libspandsp-dev libwebsockets-dev\
  && cd /usr/local/src \
  && git clone https://github.com/sipwise/rtpengine.git -b mr11.1.1.4 \
  && cd rtpengine/daemon \
  && make && make install \
  && cp /usr/local/src/rtpengine/daemon/rtpengine /usr/local/bin/rtpengine \
  && rm -Rf /usr/local/src/rtpengine \
  && apt-get purge -y --quiet --force-yes --auto-remove \
  ca-certificates gcc g++ make build-essential git markdown \
  && rm -rf /var/lib/apt/* \
  && rm -rf /var/lib/dpkg/* \
  && rm -rf /var/lib/cache/* \
  && rm -Rf /var/log/* \
  && rm -Rf /usr/local/src/* \
  && rm -Rf /var/lib/apt/lists/* 

VOLUME ["/tmp"]

#EXPOSE 39000-65000/udp 2223/udp

COPY ./entrypoint.sh /entrypoint.sh

COPY ./rtpengine.conf /etc

ENTRYPOINT ["/entrypoint.sh"]

CMD ["rtpengine"]
