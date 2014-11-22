#! /bin/sh

gorunner="$(dirname "$0")/../Resources/gorunner"
"$gorunner" -s -t "golint" golint "$BB_DOC_PATH"
