FROM wetee/gramine-ubuntu:22.04

RUN apt update && DEBIAN_FRONTEND=noninteractive  apt install -y wget build-essential libpcre3 libpcre3-dev zlib1g zlib1g-dev libssl-dev libgd-dev libxml2 libxml2-dev uuid-dev python3

# app install
ADD helloworld.py /
# app install end

ADD app.manifest.template /

RUN gramine-sgx-gen-private-key \
    && gramine-manifest -Dlog_level=error -Darch_libdir=/lib/x86_64-linux-gnu -Dpy=$(realpath $(sh -c "command -v python3")) \
    app.manifest.template app.manifest

RUN mkdir /wetee

ENTRYPOINT ["/bin/sh", "-c" ,"/init_aesm.sh && gramine-sgx-sign --manifest app.manifest --output app.manifest.sgx && gramine-sgx app"]
