#### 1 Build docker image
```bash
sh script/build_docker.sh 
```

#### 2 Run docker image
```bash
docker run -p 8999:80 --device /dev/sgx/enclave --device /dev/sgx/provision  wetee/gnginx
```

#### 3 open http://localhost:8999/