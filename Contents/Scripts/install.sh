#! /bin/sh

gorunner="$(dirname "$0")/../Resources/gorunner"
goresults="$(dirname "$0")/../Resources/show_results.applescript"

"$goresults" "go install" "$BB_DOC_PATH" "$("$gorunner" go install 2>&1)"
