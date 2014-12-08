#! /bin/sh

gorunner="$(dirname "$0")/../Resources/gorunner"
goresults="$(dirname "$0")/../Resources/show_results.applescript"

results=$("$gorunner" gofmt -w "$BB_DOC_PATH" 2>&1)
"$goresults" "gofmt" "$BB_DOC_PATH" "$results"
