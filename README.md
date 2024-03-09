## Wetee TEE Image build guide

### 1 Ego docker image build
#### 1.1 Clone the repository 
```bash
git clone https://github.com/wetee-dao/examples
cd examples
cp -R ego-template my-ego-app
cd my-ego-app
```

#### 1.2 Add golang main.go
```bash

# add main.go
echo 'package main

import "fmt"

func main() {
    fmt.Println("Hello, World!")
}' > main.go

# build executable bin
ego-go build main.go

```

#### 1.3 Modify Dockerfile
```dockerfile
FROM wetee/ego-ubuntu-deploy:20.04
WORKDIR /

# Add executable file and files
ADD main  /main
# Add end

ADD keys   /keys
ADD enclave.json /enclave.json

ENTRYPOINT ["/bin/sh", "-c" ,"ego sign main && ego run main"]
```

#### 1.4 Build docker image
```bash
docker build -t my-ego-app .
```

#### 1.5 Run docker image
```bash
docker run --device /dev/sgx/enclave --device /dev/sgx/provision my-ego-app
```


### 2 Gramine docker image build
#### 2.1 Clone the repository 
```bash
git clone https://github.com/wetee-dao/examples
cd examples
cp -R gramine-template my-gramine-app
cd my-gramine-app
```

#### 2.2 Add a rust test project

```bash
# create a new rust project
cargo init
cargo build
```

#### 2.3 Modify app.manifest.template config `loader.argv` `fs.mounts` `sgx.trusted_files` `sgx.allowed_files`
```
loader.entrypoint = "file:{{ gramine.libos }}"
libos.entrypoint = "libos-entry"

loader.log_level = "{{ log_level }}"

loader.env.LD_LIBRARY_PATH = "/lib:{{ arch_libdir }}:/usr{{ arch_libdir }}"
loader.env.IN_TEE = { passthrough = true }
loader.env.APPID = { passthrough = true }
loader.env.WORKER_ADDR = { passthrough = true }

# Gramine add run CMD
loader.argv = ["/opt/rust/my-gramine-app"]
# Gramine add run CMD end


loader.uid = 1000
loader.gid = 1000

sys.enable_sigterm_injection = true
sys.enable_extra_runtime_domain_names_conf = true

fs.mounts = [
  { path = "{{ gramine.runtimedir() }}", uri = "file:{{ gramine.runtimedir() }}" },
  { path = "{{ arch_libdir }}", uri = "file:{{ arch_libdir }}" },
  { path = "/usr{{ arch_libdir }}", uri = "file:/usr{{ arch_libdir }}" },
  { type = "encrypted", key_name = "_sgx_mrsigner", path = "/wetee", uri = "file:/wetee" },
  # Gramine add mount
   { path = "/opt/rust", uri = "file:/opt/rust" },
  # Gramine add mount end
]

sgx.debug = true
sgx.edmm_enable = {{ 'true' if env.get('EDMM', '0') == '1' else 'false' }}
sgx.enclave_size = "1024M"
# sgx.max_threads = {{ '1' if env.get('EDMM', '0') == '1' else '4' }}
sgx.max_threads = 32

sgx.trusted_files = [
  "file:{{ gramine.libos }}",
  "file:{{ gramine.runtimedir() }}/",
  "file:{{ arch_libdir }}/",
  "file:/usr/{{ arch_libdir }}/",
  "file:libos-entry",
  # Gramine add trusted file
  "file:/opt/rust/my-gramine-app",
  # Gramine add trusted file end
]


sgx.allowed_files = [
  "file:/etc/hosts",
  "file:/etc/host.conf",
  "file:/etc/gai.conf",
  "file:/etc/resolv.conf",
  "file:/etc/localtime",
  "file:/etc/nsswitch.conf",
  "file:/wetee/",
  # Gramine add file

]

# enable DCAP
sgx.remote_attestation = "dcap"
```

#### 2.4 Build docker image
- Modify Dockerfile
```dockerfile
FROM wetee/gramine-ubuntu:20.04

# app install
ADD target/debug/my-gramine-app /opt/rust/
# app install end

ADD app.manifest.template /

RUN gramine-sgx-gen-private-key \
    && gramine-manifest -Dlog_level=error -Darch_libdir=/lib/x86_64-linux-gnu app.manifest.template app.manifest

RUN mkdir /wetee

ENTRYPOINT ["/bin/sh", "-c" ,"/init_aesm.sh && gramine-sgx-sign --manifest app.manifest --output app.manifest.sgx && gramine-sgx app"]
```


- Build docker image
```bash
docker build -t my-app .
```

#### 2.5 Run docker image
```bash
docker run --device /dev/sgx/enclave --device /dev/sgx/provision my-app
```
