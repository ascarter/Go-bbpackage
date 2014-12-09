#! /bin/sh

PATH="$(dirname "$0")/../Resources":$PATH
(gorunner go build $(gorunner go list) 2>&1) | awk '{print "error:" $0}' | goresults -t "go build"