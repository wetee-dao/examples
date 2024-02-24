#### 1 Build docker image
```bash
# build executable bin
g++ -o hello hello.cpp 

docker build -t my-app .
```

#### 2 Run docker image
```bash
docker run --device /dev/sgx/enclave --device /dev/sgx/provision my-app
```

#### 3 Find "Hello, world!" in log