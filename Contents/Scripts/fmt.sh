#! /bin/sh

gorunner="$(dirname "$0")/../Resources/gorunner"
goresults="$(dirname "$0")/../Resources/show_results.applescript"

"$goresults" "go fmt" "$BB_DOC_PATH" "$("$gorunner" gofmt -w "$BB_DOC_PATH" 2>&1)"
