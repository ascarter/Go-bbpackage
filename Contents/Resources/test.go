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
	Name string "foo"
	Age  int
}

type SuperThing struct {
	nickname string
	size int
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
	Name string "foo"
	// With comments!
	Age  int
}) int {
	// This is a really ugly way to do it...
	return 5
}

func foo3(v interface{}) int {
	return 10
}

func foo4(v interface {
	Read(b []byte);
	// With comments!
	Close()
}) int {
	// This is really ugly...
	return 5
}

func foo5(handler func(x int, y string))int {
	return 5
}

func foo6(x ...int) int{
	return 5
}

func foo7(first, last string) string {
	return fmt.Sprintf("%s %s", first, last)
}

func _mapTest(myMap map[string]interface{}) int {
	return 5
}

func b1234ar(w http.ResponseWriter, r http.Request) (string, int) {
	fmt.Fprintf(w, "Hello")
	return "abc", 10
}

func (p *Thing) init(fset *http.Request, filename string, src byte) (ret int) {
	fmt.Printf("%s", filename)
	return

}

func (p *Thing) Get(key string) (interface{}, error) {
	return "string", nil
}

func (p *Thing) GetAny(key string) interface{} {
	return "string"
}

fmt.Prin

func (p *Thing) newThing(thing2 Thing) (Thing, error) {
	return thing2, nil
}

func NewSuperThing(size int) (SuperThing, error) {
	return SuperThing{"superthing", size}, nil
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

func (t *Thing) makeNamedChannels(in <-chan int, out chan<- int)(c1 <-chan int, c2 chan<- int) {
	return in, out
}
