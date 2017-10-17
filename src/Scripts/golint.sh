#!/bin/sh

PATH="$(dirname "$0")/../Resources":$PATH
(gorunner golint "$BB_DOC_PATH" 2>&1) | awk '{print "warning:" $0}' | bbr -t "golint"
