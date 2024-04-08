FROM wetee/gramine-ubuntu:22.04

RUN apt update && DEBIAN_FRONTEND=noninteractive  apt install -y wget build-essential libpcre3 libpcre3-dev zlib1g zlib1g-dev libssl-dev libgd-dev libxml2 libxml2-dev uuid-dev

# nginx install
RUN wget -O nginx.tar.gz  http://nginx.org/download/nginx-1.22.0.tar.gz \
    && tar --touch -xzf nginx.tar.gz \
    && cd nginx-1.22.0 \
    && ./configure --prefix=/opt/nginx --without-http_rewrite_module --with-http_ssl_module\
    && make install

ADD nginx.conf /opt/nginx/conf/
ADD nginx.manifest.template /
# nginx install end

RUN gramine-sgx-gen-private-key \
    && gramine-manifest -Dlog_level=debug -Darch_libdir=/lib/x86_64-linux-gnu nginx.manifest.template nginx.manifest

RUN mkdir /wetee

ENTRYPOINT ["/bin/sh", "-c" ,"/init_aesm.sh && gramine-sgx-sign --manifest nginx.manifest --output nginx.manifest.sgx && gramine-sgx nginx"]