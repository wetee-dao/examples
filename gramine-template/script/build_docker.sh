# get shell path
SOURCE="$0"
while [ -h "$SOURCE"  ]; do
    DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /*  ]] && SOURCE="$DIR/$SOURCE"
done
DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"
cd $DIR/../

if [ -f "app.manifest" ] ; then
    rm "app.manifest"
fi
if [ -f "app.manifest.sgx" ] ; then
    rm "app.manifest.sgx"
fi
if [ -f "app.sig" ] ; then
    rm "app.sig"
fi

gramine-manifest -Dlog_level=error -Darch_libdir=/lib/x86_64-linux-gnu app.manifest.template app.manifest

docker build -t my-app .