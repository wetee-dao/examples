# get shell path
SOURCE="$0"
while [ -h "$SOURCE"  ]; do
    DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /*  ]] && SOURCE="$DIR/$SOURCE"
done
DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"

# 编译新的libos-entry
cd $DIR/../../../libos-entry/bin/
if [ -f "libos-entry" ] ; then
    rm "libos-entry"
fi

ertgo build -o libos-entry -buildmode=pie -buildvcs=false ../lib/entry/main.go
cp libos-entry $DIR/../

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
sudo rm -rf /wetee
sudo mkdir /wetee
sudo chmod 777 /wetee

export APPID=AAIAAAQAAgABAAAAEhX%2F%2F%2F%2BADgAAAAAAAAAAAAsAAAAAAAD%2FAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAmsEh%2Fd3L1MFaioQfK5EngnowPzcScScPjQtmv5kiXKl3Nf0Tt9LYBC4ou2g%3D
export WORKER_ADDR=https://192.168.111.105:32767

gramine-manifest -Dlog_level=error -Darch_libdir=/lib/x86_64-linux-gnu app.manifest.template app.manifest

gramine-sgx-sign --manifest app.manifest --output app.manifest.sgx
gramine-sgx app