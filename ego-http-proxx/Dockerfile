FROM wetee/ego-ubuntu-deploy:20.04
WORKDIR /

# Add the hello 
ADD hello  /hello
# Add the hello end

ADD keys   /keys
ADD enclave.json /enclave.json
ADD dist  /srv/dist

RUN mkdir -p /wetee

EXPOSE 8999


ENTRYPOINT ["/bin/sh", "-c" ,"ego sign hello && ego run hello"]