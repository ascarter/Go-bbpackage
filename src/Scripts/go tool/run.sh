#!/bin/sh

PATH="$(dirname "$0")/../../Resources":$PATH
gorunner go run "$BB_DOC_PATH"
