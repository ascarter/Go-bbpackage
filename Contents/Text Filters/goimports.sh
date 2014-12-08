#! /bin/sh

gorunner="$(dirname "$0")/../Resources/gorunner"
goresults="$(dirname "$0")/../Resources/show_results.applescript"

"$goresults" "goimports" "$BB_DOC_PATH" "$("$gorunner" goimports < /dev/stdin" 2>&1)"
