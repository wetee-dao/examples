FROM wetee/gramine-ubuntu:20.04

# app install
ADD target/debug/gramine-rust /opt/rust/
# app install end

ADD app.manifest.template /

RUN gramine-sgx-gen-private-key \
    && gramine-manifest -Dlog_level=debug -Darch_libdir=/lib/x86_64-linux-gnu app.manifest.template app.manifest

RUN mkdir /wetee

ENTRYPOINT ["/bin/sh", "-c" ,"gramine-sgx-sign --manifest app.manifest --output app.manifest.sgx && gramine-sgx app"]