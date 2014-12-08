#! /bin/sh

PATH="$(dirname "$0")/../Resources":$PATH
(gorunner go fix 2>&1) | awk '{print "error:" $0}' | goresults -t "go fix"
