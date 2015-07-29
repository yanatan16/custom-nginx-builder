FROM buildpack-deps:jessie

RUN echo "deb-src http://httpredir.debian.org/debian jessie main" >> /etc/apt/sources.list && \
  apt-get update && \
  apt-get install -y dpkg-dev build-essential zlib1g-dev libpcre3 libpcre3-dev unzip vim s3cmd git ntp && \
  service ntp start && \
  apt-get -t jessie build-dep -y nginx && \
  mkdir /app && cd /app && \
  apt-get -t jessie source nginx=1.6.2-5

WORKDIR /app/nginx-1.6.2

RUN cd debian/modules && \
  rm -rf headers-more-nginx-module nginx-development-kit nginx-lua && \
  git clone https://github.com/zebrafishlabs/nginx-statsd nginx-statsd && cd nginx-statsd && git checkout b756a12 && cd - && \
  git clone https://github.com/openresty/encrypted-session-nginx-module encrypted-session-nginx-module && cd encrypted-session-nginx-module && git checkout v0.04 && cd - && \
  git clone https://github.com/openresty/headers-more-nginx-module headers-more-nginx-module && cd headers-more-nginx-module && git checkout v0.261 && cd - && \
  git clone https://github.com/nbs-system/naxsi naxsi && cd naxsi && git checkout 0.53-2 && cd - && \
  git clone https://github.com/simpl/ngx_devel_kit nginx-development-kit && cd nginx-development-kit && git checkout v0.2.19 && cd - && \
  git clone https://github.com/openresty/redis2-nginx-module redis2-nginx-module && cd redis2-nginx-module && git checkout v0.12 && cd - && \
  git clone https://github.com/openresty/set-misc-nginx-module set-misc-nginx-module && cd set-misc-nginx-module && git checkout v0.29 && cd - && \
  git clone https://github.com/openresty/lua-nginx-module nginx-lua && cd nginx-lua && git checkout v0.9.16 && cd -

ADD rules /app/nginx-1.6.2/debian/rules
ADD changelog /tmp/changelog

RUN cat debian/changelog >> /tmp/changelog; \
  mv /tmp/changelog debian/changelog; \
  head -n 30 debian/changelog

RUN dpkg-buildpackage -b