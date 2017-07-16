#!/bin/sh

PATH="$(dirname "$0")/../Resources":$PATH
(gorunner guru 2>&1) | bbr -t "go build"
