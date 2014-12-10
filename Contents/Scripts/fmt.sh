#! /bin/sh

PATH="$(dirname "$0")/../Resources":$PATH
(gorunner gofmt -w "$BB_DOC_PATH" 2>&1) | awk '{print "error:" $0}' | bbresults -t "go fmt"
