upsearch () {
    local start_path=$1
    local go_path=$start_path
    while [[ "$go_path" != "" && ! -e "$go_path/$2" ]]; do
        go_path=${go_path%/*}
    done
    echo "$go_path"
}

# Execute go command from go path root using pkg path
go_cmd() {
    local CMD=${1}
    local ARGS=
    local DOC=$2
    local DOC_PATH=`dirname ${DOC}`
    local GOPKGROOT=`upsearch $DOC_PATH src`
    local PKG_PATH=`echo ${DOC_PATH#$GOPKGROOT/src/}`
    
    if [[ "$CMD" == "run" ]]; then
        ARGS=${DOC}
    else
        ARGS=${PKG_PATH}
    fi
    
    cd $GOPKGROOT
    GOPATH=$GOPKGROOT go ${CMD} ${ARGS}
    
}
