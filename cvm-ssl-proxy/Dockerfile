FROM ubuntu:22.04

# RUN apk add --no-cache bash

ADD /ssl-proxy/ssl-proxy /
ADD /env /
ADD /run.sh /

RUN chmod +x /run.sh

ENTRYPOINT ["bash","-c","/run.sh"]