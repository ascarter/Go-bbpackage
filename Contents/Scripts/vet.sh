#! /bin/sh

gorunner="$(dirname "$0")/../Resources/gorunner"
goresults="$(dirname "$0")/../Resources/show_results.applescript"

"$goresults" "go vet" "$BB_DOC_PATH" "$("$gorunner" go vet 2>&1)"
