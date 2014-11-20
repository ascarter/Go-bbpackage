on errLine(msg)
end errLine

on errorMessage()
end errorMessage

-- Load package library
tell application "Finder" to set packageRoot to (container of (container of (path to me))) as alias
set thePackage to load script (((packageRoot as string) & "Resources:lib.scpt") as alias)

tell application "BBEdit"
	set theDocument to first text document
end tell

-- Run lint
try
	tell thePackage to set env to getShellEnv(theDocument)
	tell application "BBEdit" to set sourcePath to file of theDocument
	set lintResults to do shell script env & " golint " & quoted form of POSIX path of sourcePath
	repeat with lintLine in lintResults
		log lintLine
	end repeat
on error goErrorMsg number status
	log "Error: " & goErrorMsg & " status: " & status
end try
