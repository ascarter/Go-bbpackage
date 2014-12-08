#! /bin/sh

gorunner="$(dirname "$0")/../Resources/gorunner"
goresults="$(dirname "$0")/../Resources/results"

("$gorunner" golint "$BB_DOC_PATH" 2>&1) | awk '{print "warning:" $0}' | "$goresults" -t "golint"
#"$goresults" "golint" "$BB_DOC_PATH" "$results"
