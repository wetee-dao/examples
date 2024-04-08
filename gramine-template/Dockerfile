FROM wetee/gramine-ubuntu:22.04

# app install

# app install end

ADD app.manifest.template /

RUN gramine-sgx-gen-private-key \
    && gramine-manifest -Dlog_level=error -Darch_libdir=/lib/x86_64-linux-gnu app.manifest.template app.manifest

RUN mkdir /wetee

ENTRYPOINT ["/bin/sh", "-c" ,"/init_aesm.sh && gramine-sgx-sign --manifest app.manifest --output app.manifest.sgx && gramine-sgx app"]
