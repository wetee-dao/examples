FROM livekit/livekit-server

WORKDIR /

ADD ./run.sh /
RUN chmod +x /run.sh

ENTRYPOINT ["/bin/sh", "-c", "/run.sh"]