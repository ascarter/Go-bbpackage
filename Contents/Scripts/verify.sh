#!/bin/sh

PATH="$(dirname "$0")/../Resources":$PATH

# Expect BB_DOC_LANGUAGE, BB_DOC_MODE, BB_DOC_NAME, BB_DOC_PATH
# On save, run goimports, golint, go vet
(
	(gorunner goimports -w "$BB_DOC_PATH" 2>&1)
	(gorunner golint "$BB_DOC_PATH" 2>&1) | awk '{print "warning:" $0}'
	(gorunner go vet 2>&1)
	(gorunner go build $(gorunner go list) 2>&1)
) | bbresults -t "Verify"
