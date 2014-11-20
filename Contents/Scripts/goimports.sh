#!/bin/sh

SCRIPT_PATH="${BASH_SOURCE[0]}"
source "`dirname "${SCRIPT_PATH}"`/../Resources/upsearch"

DOC=`basename "${BB_DOC_PATH}"`
DOC_PATH=`dirname "${BB_DOC_PATH}"`
GOPKGROOT=`upsearch "${DOC_PATH}" src`
PKG_PATH=`echo ${DOC_PATH#$GOPKGROOT/src/}`
GOIMPORTS=${GOPKGROOT}/bin/goimports

if [ -x "${GOIMPORTS}" ]; then
    cd ${GOPKGROOT}/src
    GOPATH=${GOPKGROOT} ${GOIMPORTS} -w "${PKG_PATH}/${DOC}"
else
    printf "The package goimports is not installed\n\nInstall goimports with following command:\n\tgo get golang.org/x/tools/cmd/goimports"
fi
