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

int main(int argc, char *argv)
{
  printf("Hello");
}

package main
import (
  "fmt"
  "github.com/user/newmath"
)

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

func foo() int {
  return 5;
}

func bar() {
  return 6;
}

func (p *parser) init(fset *token.Fileset, filename string, src []byte) (ret int) {
  p.file = fset.Addfile(filename, -1, len(src))
}
