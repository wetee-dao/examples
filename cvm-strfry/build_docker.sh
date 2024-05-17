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

chmod +x run.sh 

docker build -t wetee/strfry:$tag .
docker push wetee/strfry:$tag

# docker run -e ser_port=7880 -e udp_port=7881 -e tcp_port=7882 -e node_ip=127.0.0.1 -p 7880:7880 -p 7881:7881 -p 7882:7882/udp wetee/cvm-livekit-server:$tag /run.sh