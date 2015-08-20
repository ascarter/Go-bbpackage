#!/bin/sh

PATH="$(dirname "$0")/../Resources":"$(dirname "$0")":$PATH

# Expect BB_DOC_LANGUAGE, BB_DOC_MODE, BB_DOC_NAME, BB_DOC_PATH
# On save, run goimports, golint, go vet
(
    goimports.sh
    golint.sh
    vet.sh
    build.sh
) | bbresults -t "Verify"
