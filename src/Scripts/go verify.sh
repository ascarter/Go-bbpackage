#!/bin/sh

PATH="$(dirname "$0")/../Resources":$PATH

# Expect BB_DOC_LANGUAGE, BB_DOC_MODE, BB_DOC_NAME, BB_DOC_PATH
# On save, run goimports, golint, go vet
(
    goimports.sh
    golint.sh
    vet.sh
) | bbr -t "Verify"
