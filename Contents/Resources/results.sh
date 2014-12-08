#!/bin/sh

# Show results browser for each entry on stdin
# Format:
#   [error|warning|note]:[path]:[line]:[col]: [msg]


makeEntry() {
    
}


TITLE="Test Results"
DATA="{result_kind:warning_kind, result_file:POSIX file \"$BB_DOC_PATH\", result_line:14, message:\"exported function Blah should have comment or be unexported\"}"

# Build entries
while read line
do
    echo $line
    makeEntry $line
done

osascript -l AppleScript - <<SCRIPT
tell application "BBEdit"
    set resultsData to {$DATA}
    log resultsData
    make new results browser with data resultsData with properties {name:"$TITLE"}
end tell
SCRIPT
