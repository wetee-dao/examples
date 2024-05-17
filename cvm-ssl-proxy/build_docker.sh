# get shell path
SOURCE="$0"
while [ -h "$SOURCE"  ]; do
    DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /*  ]] && SOURCE="$DIR/$SOURCE"
done
DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"
cd $DIR/

tag=`date "+%Y-%m-%d-%H-%M"`

cd $DIR/ssl-proxy
go build -o ssl-proxy ./main.go

cd $DIR/

docker build -t wetee/cvm-ssl-proxy:$tag .
docker push wetee/cvm-ssl-proxy:$tag