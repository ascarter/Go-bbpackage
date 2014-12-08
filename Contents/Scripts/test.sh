#! /bin/sh

PATH="$(dirname "$0")/../Resources":$PATH
gorunner go test $(gorunner go list)
