FROM ubuntu:latest
MAINTAINER Marcelo M. Fleury <marcelomf@gmail.com>
#nagev based

ENV TORNAME tor-0.2.5.10

WORKDIR /opt
ADD . /opt

RUN apt-get update
RUN apt-get install -yq \ 
  libwww-perl \
  build-essential \
  libevent-dev \
  libssl-dev \
  vim \
  curl \
  wget \
  lynx \
  links \
  privoxy \
  proxychains \
  telnet \
  expect \
  netcat \
  haproxy \
  polipo \
  tinyproxy \
  squid \
  jesred \
  lightsquid \
  httrack
RUN GET https://www.torproject.org/dist/${TORNAME}.tar.gz | tar xz -C /tmp

RUN cd /tmp/${TORNAME} && ./configure && make && make install
RUN rm -rf /tmp/${TORNAME}
RUN chmod +x /opt/*.sh

EXPOSE 9150
EXPOSE 9000
RUN echo "Log notice stdout" >> /etc/torrc

CMD /opt/./start.sh 2>/dev/null 9150 9000
