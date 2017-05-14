#!/bin/sh

PATH="$(dirname "$0")/../Resources":$PATH
cd $(gorunner git rev-parse --show-toplevel)
bbedit --maketags
