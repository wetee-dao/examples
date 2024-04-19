# get shell path
SOURCE="$0"
while [ -h "$SOURCE"  ]; do
    DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /*  ]] && SOURCE="$DIR/$SOURCE"
done
DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"
cd $DIR/../

# 编译新的libos-entry
cd $DIR/../../../libos-entry/bin/
if [ -f "libos-entry" ] ; then
    rm "libos-entry"
fi

cp libos-entry $DIR/../

if [ -f "app.manifest" ] ; then
    rm "app.manifest"
fi
if [ -f "app.manifest.sgx" ] ; then
    rm "app.manifest.sgx"
fi
if [ -f "app.sig" ] ; then
    rm "app.sig"
fi

cd $DIR/../


sudo rm -rf /wetee
sudo mkdir /wetee
sudo chmod 777 /wetee


sudo cp -r src /opt/app


export APPID=AAIAAAQAAgABAAAAEhX%2F%2F%2F%2BADgAAAAAAAAAAAAsAAAAAAAD%2FAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAmsEh%2Fd3L1MFaioQfK5EngnowPzcScScPjQtmv5kiXKl3Nf0Tt9LYBC4ou2g%3D
export WORKER_ADDR=https://192.168.111.105:32767

gramine-manifest -Dlog_level=error \
    -Darch_libdir=/lib/x86_64-linux-gnu \
    -Dnodejs_dir=/opt/nodejs \
    app.manifest.template app.manifest 
gramine-sgx-sign --manifest app.manifest --output app.manifest.sgx
gramine-sgx app