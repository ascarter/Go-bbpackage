#! /bin/sh

gorunner="$(dirname "$0")/../Resources/gorunner"
"$gorunner" go test $("$gorunner" go list)
