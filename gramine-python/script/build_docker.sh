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

tag=`date "+%Y-%m-%d-%H-%M"`

docker build -t wetee/gpython:$tag .
docker push wetee/gpython:$tag