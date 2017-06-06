#!/bin/sh

PATH="$(dirname "$0")/../../Resources":$PATH
def=$(gorunner godef -t -f "$BB_DOC_PATH" -o $BB_DOC_SELSTART)
osascript - "$def" <<EOF
on run argv
  display dialog argv
end run
EOF
