#!/bin/sh

SCRIPT_PATH="${BASH_SOURCE[0]}"
source "`dirname "${SCRIPT_PATH}"`/../Resources/upsearch"

DOC=`basename "${BB_DOC_PATH}"`
DOC_PATH=`dirname "${BB_DOC_PATH}"`
GOPKGROOT=`upsearch "${DOC_PATH}" src`
PKG_PATH=`echo ${DOC_PATH#$GOPKGROOT/src/}`
GOLINT=${GOPKGROOT}/bin/golint

if [ -x "${GOLINT}" ]; then
    cd ${GOPKGROOT}/src
    GOPATH=${GOPKGROOT} ${GOLINT} "${PKG_PATH}/${DOC}"
else
    printf "The package golint is not installed\n\nInstall golint with following command:\n\tgo get github.com/golang/lint/golint"
fi
