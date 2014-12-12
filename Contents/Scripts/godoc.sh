#!/bin/sh

while [[ $# > 1 ]]; do
	OPT="$1"
	shift
	
	case $OPT in
		-pkg|--pkg)
			PKGPATH=$1
			shift
			;;
	esac
done

if [ -n "$PKGPATH" ]; then
	PATH="$(dirname "$0")/../Resources":$PATH
	gorunner godoc "$PKGPATH" 2>&1
fi
