#! /bin/sh

gorunner="$(dirname "$0")/../Resources/gorunner"
"$gorunner" -s -t "go build" go build $("$gorunner" go list)
