#### 1 Build docker image
```bash
sh script/build_docker.sh 
```

#### 2 Run docker image
```bash
docker run --device /dev/sgx/enclave --device /dev/sgx/provision  wetee/grust-app
```

#### 3 Find "Hello, world!" in log