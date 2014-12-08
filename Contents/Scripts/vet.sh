#! /bin/sh

PATH="$(dirname "$0")/../Resources":$PATH
(gorunner go vet 2>&1) | awk '{print "error:" $0}' | goresults -t "go vet"
