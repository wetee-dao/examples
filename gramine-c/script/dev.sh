# get shell path
SOURCE="$0"
while [ -h "$SOURCE"  ]; do
    DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /*  ]] && SOURCE="$DIR/$SOURCE"
done
DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"

# # 编译新的libos-entry
# cd $DIR/../../../libos-entry/bin/
# if [ -f "libos-entry" ] ; then
#     rm "libos-entry"
# fi
# CGO_CFLAGS=-I/opt/ego/include CGO_LDFLAGS=-L/opt/ego/lib ertgo build -o libos-entry -buildmode=pie -buildvcs=false ../lib/entry/main.go
# cp libos-entry $DIR/../

# 运行程序
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

sudo cp ./hello /srv/hello

gramine-manifest -Dlog_level=error -Darch_libdir=/lib/x86_64-linux-gnu app.manifest.template app.manifest

gramine-sgx-sign --manifest app.manifest --output app.manifest.sgx
gramine-sgx app