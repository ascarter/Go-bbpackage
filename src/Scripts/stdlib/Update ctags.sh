#!/bin/sh

#
# Regenerate Go standard library symbols
#

GOROOT=$(go env GOROOT)
SRC_FILES=$(find ${GOROOT}/src \! -path "**/testdata/**" \! -path "**/internal/**" \! -path "*_test.go" -print)
CTAGS_FILE="$(dirname "$0")/../../Completion Data/Go/Go Standard Library.tags"
CTAGS=/Applications/BBEdit.app/Contents/Helpers/ctags
CTAGS_ARGS="--languages=Go --extra=+p+q+r --fields=+a+m+n+S --excmd=number --tag-relative=no --sort=no"

# Create Completion Data directory
mkdir -p "$(dirname "${CTAGS_FILE}")"

# Filter non-public symbols
${CTAGS} ${CTAGS_ARGS} -f - ${SRC_FILES} | grep -v -E '^(\w+[.])?[^A-Z]\w+\s+\S+\s\d+[;]["]\s+[cfimstv]' > ${CTAGS_FILE}
