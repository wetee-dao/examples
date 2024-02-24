#### 1 Build docker image
```bash
docker build -t my-app .
```

#### 2 Run docker image
```bash
docker run --device /dev/sgx/enclave --device /dev/sgx/provision my-app
```

#### 3 Find "Hello World" in log