package main

import (
	"fmt"
	"net/http"

	"github.com/wetee-dao/libos-entry/lib/ego"
)

func main() {
	err := ego.InitEgo("")
	if err != nil {
		panic(err)
	}

	http.HandleFunc("/", resourceHandler)
	err = http.ListenAndServe(":8999", nil)
	if err != nil {
		panic(err)
	}
}

var staticDir = "/srv/dist"

func resourceHandler(w http.ResponseWriter, req *http.Request) {
	fmt.Printf("Serving up path %s", req.URL.Path)
	if req.URL.Path == "/" || req.URL.Path == "" {
		fmt.Printf("...redirecting to [" + staticDir + "/index.html]")
		http.ServeFile(w, req, staticDir+"/index.html")
	} else {
		http.ServeFile(w, req, staticDir+"/"+req.URL.Path)
	}
}
