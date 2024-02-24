FROM wetee/gramine-ubuntu:20.04

RUN apt update && DEBIAN_FRONTEND=noninteractive  apt install -y wget build-essential libpcre3 libpcre3-dev zlib1g zlib1g-dev libssl-dev libgd-dev libxml2 libxml2-dev uuid-dev

# app install
ADD hello /srv/hello
# app install end

ADD app.manifest.template /

RUN gramine-sgx-gen-private-key \
    && gramine-manifest -Dlog_level=debug -Darch_libdir=/lib/x86_64-linux-gnu app.manifest.template app.manifest

RUN mkdir /wetee

ENTRYPOINT ["/bin/sh", "-c" ,"gramine-sgx-sign --manifest app.manifest --output app.manifest.sgx && gramine-sgx app"]
