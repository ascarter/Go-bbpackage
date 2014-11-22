#! /bin/sh

gorunner="$(dirname "$0")/../Resources/gorunner"
"$gorunner" -s -t "go fix" go fix
