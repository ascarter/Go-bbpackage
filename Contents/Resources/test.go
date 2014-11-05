// Go test

/*
This is at test of the go syntax parser
*/

/*

Here is a function in a comment:
func main() int {
fmt.Println("hello")
}
*/

package main

import (
	"fmt"
	"net/http"
)

type Thing struct {
	Name string
	Age  int
}

// Main method
func main() {
	fmt.Println("Hello world\"")
	fmt.Println(`Hello world!
that spans more than one line`)
	fmt.Println('l')
	fmt.Println('\'')

}

// A function
func Sqrt(x float64) float64 {
	z := 1.0
	for i := 0; i < 1000; i++ {
		z -= (z*z - x) / (2 * z)
	}
	return z
}

func foo() int { return 5 }

func foo2(v struct {
	Name string 'foo'
	Age  int
}) int {
	return 5
}

func foo3(v interface {
	Read(b []byte)
	Close()
}) int {
	return 5
}

func foo4(handler func(x int, y string))int {
	return 5
}

func foo5(x ...int) int{
	return 5
}

func _mapTest(myMap map[string]interface{}) int {
	return 5
}

func b1234ar(w http.ResponseWriter, r *http.Request) (string, int) {
	fmt.Fprintf(w, "Hello")
	return "abc", 10
}

func (p *Thing) init(fset *http.Request, filename string, src []byte) (ret int) {
	fmt.Printf("%s", filename)
	return

}

func (t *Thing) makeInChan(c <-chan int) <-chan int {
	out := make(chan int)
	return out
}

func (t *Thing) mergeChan(c chan<- int) chan<- int {
	out := make(chan int)
	return out
}

func (t *Thing) makeOutChan(c <-chan int) chan<- int {
	out := make(chan int)
	return out
}

func (t *Thing) makeChannels(in <-chan int, out chan<- int)(<-chan int, chan<- int) {
	return in, out
}
