#! /bin/sh

gorunner="$(dirname "$0")/../Resources/gorunner"
"$gorunner" -s -t "go fmt" gofmt -w "$BB_DOC_PATH"
