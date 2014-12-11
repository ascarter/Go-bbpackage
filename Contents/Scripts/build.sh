#!/bin/sh

PATH="$(dirname "$0")/../Resources":$PATH
(gorunner go build $(gorunner go list) 2>&1) | bbresults -t "go build"
