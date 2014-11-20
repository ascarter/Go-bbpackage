#!/bin/sh

SCRIPT_PATH="${BASH_SOURCE[0]}"
GOCMD="`dirname "${SCRIPT_PATH}"`/../Resources/gocmd"
"${GOCMD}" fmt "${BB_DOC_PATH}"
