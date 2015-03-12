#!/bin/sh

PATH="$(dirname "$0")/../Resources":$PATH
gorunner bbedit $GOROOT/src
