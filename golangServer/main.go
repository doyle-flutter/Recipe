// go get github.com/julienschmidt/httprouter
// go build main.go
// ./main

package main

import (
    "fmt"
    "github.com/julienschmidt/httprouter"
    "net/http"
    "log"
)

type MyClass struct {
        i int
        s string
}

func Index(w http.ResponseWriter, r *http.Request, _ httprouter.Params) {
        fmt.Fprint(w, "hello! Golang!")
}

func Hello(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {
        data := MyClass{1,"Golang & "}
    fmt.Fprintf(w, data.s + ps.ByName("name"))
}

func main() {
    router := httprouter.New()
    router.GET("/", Index)
    router.GET("/hello/:name", Hello)

    log.Fatal(http.ListenAndServe(":8080", router))
}
