#!/bin/sh

PATH="$(dirname "$0")/../../Resources":$PATH
(gorunner go fix 2>&1) | bbr -t "go fix"
