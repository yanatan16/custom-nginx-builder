FROM buildpack-deps:jessie

RUN echo "deb-src http://httpredir.debian.org/debian jessie main" >> /etc/apt/sources.list && \
  apt-get update && \
  apt-get install -y dpkg-dev build-essential zlib1g-dev libpcre3 libpcre3-dev unzip vim s3cmd && \
  apt-get -t jessie build-dep -y nginx && \
  mkdir /app && cd /app && \
  apt-get -t jessie source nginx=1.6.2-5

WORKDIR /app

ADD instructions.txt /app/instructions.txt