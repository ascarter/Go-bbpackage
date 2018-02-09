#!/bin/sh

while [[ $# > 1 ]]; do
	OPT="$1"
	shift

	case $OPT in
		-command|--command)
			CMD=$1
			shift
			;;
	esac
done

PATH="$(dirname "$0")/../Resources":$PATH

echo "Received command: ${CMD}"

case $CMD in

	<#match pattern#>)
		<#commands#>
		;;

	<#match pattern#> | <#match pattern#>)
		<#commands#>
		;;

	*)
		<#default commands#>
		;;
esac





(gorunner go ${CMD} $(gorunner go list) 2>&1) | bbr -t "go ${CMD}"


# if [ -n "$PKG" ]; then
# 
# PATH="$(dirname "$0")/../Resources":$PATH
# (gorunner go build $(gorunner go list) 2>&1) | bbr -t "go build"
