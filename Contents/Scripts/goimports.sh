#! /bin/sh

gorunner="$(dirname "$0")/../Resources/gorunner"
goresults="$(dirname "$0")/../Resources/show_results.applescript"

results=$("$gorunner" goimports -w "$BB_DOC_PATH" 2>&1)
"$goresults" "goimports" "$BB_DOC_PATH" "$results"
