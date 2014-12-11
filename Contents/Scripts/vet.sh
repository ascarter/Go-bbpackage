#!/bin/sh

PATH="$(dirname "$0")/../Resources":$PATH
(gorunner go vet 2>&1) | bbresults -t "go vet"
