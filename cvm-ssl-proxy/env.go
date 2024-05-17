package main

import (
	"encoding/base64"
	"fmt"
	"os"
	"strings"
)

func main() {
	// 获取命令行参数
	args := os.Args
	keys := strings.Split(args[1], "|")
	fmt.Println(keys)

	key, _ := base64.StdEncoding.DecodeString(keys[0])
	os.WriteFile("key.pem", key, 0644)

	cert, _ := base64.StdEncoding.DecodeString(keys[1])
	os.WriteFile("cert.pem", cert, 0644)
}
