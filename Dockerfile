FROM ubuntu:20.04
MAINTAINER Richard Yu <xiaoqingfengatgm@gmail.com>
# https://github.com/xiaoqingfengATGH/lantern
# lastest lantern version: 7.4.0
WORKDIR /root
RUN apt-get update  && \
         apt-get -y install wget libappindicator3-1 libpcap0.8:amd64 && \
	 wget -O lantern.deb https://github.com/getlantern/lantern-binaries/raw/main/lantern-installer-64-bit.deb?ver=7.4.0 && \
	 wget -O settings.yaml https://raw.githubusercontent.com/xiaoqingfengATGH/lantern/master/settings.yaml?ver=7.4.0 && \
         dpkg -i lantern.deb && \
         rm -rf lantern.deb && \
         apt-get -f install && \
         apt-get clean && \
         rm -rf /var/cache/apt/* /var/lib/apt/lists/* && \
         mkdir /root/.lantern && \
         mv settings.yaml /root/.lantern/settings.yaml

EXPOSE 3128/tcp 8080/tcp 3129/tcp

ENTRYPOINT ["/usr/bin/lantern", "--configdir=/root/.lantern", "--headless=true"]
