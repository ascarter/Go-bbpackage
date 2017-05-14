#!/bin/sh

PATH="$(dirname "$0")/../Resources":$PATH
(gorunner go test $(gorunner go list) 2>&1) | bbr -t "go test"
