#! /bin/sh

PATH="$(dirname "$0")/../Resources":$PATH
(gorunner go clean 2>&1) | awk '{print "error:" $0}' | bbresults -t "go clean"
