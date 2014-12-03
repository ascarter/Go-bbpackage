#! /bin/sh

gorunner="$(dirname "$0")/../Resources/gorunner"
goresults="$(dirname "$0")/../Resources/show_results.applescript"

"$goresults" "go build" "$BB_DOC_PATH" "$("$gorunner" go build $("$gorunner" go list) 2>&1)"
