# get shell path
SOURCE="$0"
while [ -h "$SOURCE"  ]; do
    DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /*  ]] && SOURCE="$DIR/$SOURCE"
done
DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"
cd $DIR/../

if [ -f "nginx.manifest" ] ; then
    rm "nginx.manifest"
fi
if [ -f "nginx.manifest.sgx" ] ; then
    rm "nginx.manifest.sgx"
fi
if [ -f "nginx.sig" ] ; then
    rm "nginx.sig"
fi

gramine-manifest -Dlog_level=debug -Darch_libdir=/lib/x86_64-linux-gnu app.manifest.template app.manifest

gramine-sgx-sign --manifest app.manifest --output app.manifest.sgx
gramine-sgx app