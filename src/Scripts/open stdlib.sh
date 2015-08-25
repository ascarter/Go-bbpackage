#!/bin/sh

PATH="$(dirname "$0")/../Resources":$PATH
GOROOT=`go env GOROOT`
gorunner bbedit $GOROOT/src
