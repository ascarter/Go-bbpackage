#! /bin/sh

gorunner="$(dirname "$0")/../Resources/gorunner"
goresults="$(dirname "$0")/../Resources/show_results.applescript"

"$goresults" "golint" "$BB_DOC_PATH" "$("$gorunner" golint "$BB_DOC_PATH" 2>&1)"
