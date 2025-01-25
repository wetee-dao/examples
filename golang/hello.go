package main

import (
	"fmt"
	"net/http"

	"github.com/wetee-dao/libos-entry/entry/ego"
)

func main() {
	err := ego.InitLocalEgo()
	if err != nil {
		panic(err)
	}

	/// Use TEE to encrypt data
	v, err := ego.Fs.Encrypt([]byte("hello world"))
	if err != nil {
		panic(err)
	}

	/// Use TEE to decrypt data
	text, err := ego.Fs.Decrypt(v)
	if err != nil {
		panic(err)
	}
	fmt.Println(string(text))

	/// Write data with TEE
	err = ego.Fs.WriteFile("hello.txt", []byte("test"), 0644)
	if err != nil {
		panic(err)
	}

	/// Read data with TEE
	text, err = ego.Fs.ReadFile("hello.txt")
	if err != nil {
		panic(err)
	}

	http.HandleFunc("/", resourceHandler)
	err = http.ListenAndServe(":8999", nil)
	if err != nil {
		panic(err)
	}
}

func resourceHandler(w http.ResponseWriter, req *http.Request) {
	w.WriteHeader(http.StatusOK)
	w.Write([]byte("hello world"))
}
