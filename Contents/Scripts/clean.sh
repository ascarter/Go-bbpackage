#! /bin/sh

gorunner="$(dirname "$0")/../Resources/gorunner"
goresults="$(dirname "$0")/../Resources/show_results.applescript"

"$goresults" "go clean" "$BB_DOC_PATH" "$("$gorunner" go clean 2>&1)"
