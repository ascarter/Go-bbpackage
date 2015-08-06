#!/bin/sh

PATH="$(dirname "$0")/../Resources":$PATH
(gorunner go install 2>&1) | bbresults -t "go install"
