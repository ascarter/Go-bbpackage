#!/bin/sh

PATH="$(dirname "$0")/../Resources":$PATH
(gorunner goimports -w "$BB_DOC_PATH" 2>&1) | bbresults -t "goimports"
