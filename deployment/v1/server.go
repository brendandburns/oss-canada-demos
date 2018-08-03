package main

import (
	"flag"
	"fmt"
	"log"
	"net/http"
)

var addr = flag.String("address", ":8080", "The address to serve on")

const version = "v1"

func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello Azure OSS! Version: %s\n", version)
}

func main() {
	flag.Parse()

	http.HandleFunc("/", handler)
	if err := http.ListenAndServe(*addr, nil); err != nil {
		log.Fatalf("Couldn't serve: %v", err)
	}
}
