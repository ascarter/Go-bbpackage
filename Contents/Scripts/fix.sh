#! /bin/sh

gorunner="$(dirname "$0")/../Resources/gorunner"
goresults="$(dirname "$0")/../Resources/show_results.applescript"

"$goresults" "go fix" "$BB_DOC_PATH" "$("$gorunner" go fix 2>&1)"
