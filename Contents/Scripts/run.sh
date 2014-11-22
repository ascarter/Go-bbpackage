#! /bin/sh

gorunner="$(dirname "$0")/../Resources/gorunner"
"$gorunner" go run "$BB_DOC_PATH"
