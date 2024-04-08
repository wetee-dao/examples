FROM wetee/ego-ubuntu-deploy:22.04
WORKDIR /

# Add executable file and files
# example ADD hello  /hello
# Add end

ADD keys   /keys
ADD enclave.json /enclave.json

# Expose port
EXPOSE 8999


ENTRYPOINT ["/bin/sh", "-c" ,"ego sign hello && ego run hello"]