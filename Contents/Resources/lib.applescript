on packageName()
	return "Go"
end packageName

property packageRoot : null

-- getShellEnv uses the document to infer the Go workspace and sets PATH and GOPATH for shell scripts
on getShellEnv(theDocument)
	tell application "BBEdit" to set theFile to (file of theDocument)
	
	-- Find GOPATH
	tell application "Finder"
		set cwd to (container of (theFile as alias))
		-- Look for required GOPATH/{src,pkg,bin} directories to find Go workspace root
		repeat
			if ((exists (cwd as string) & "src") and (exists (cwd as string) & "pkg") and (exists (cwd as string) & "bin")) then
				exit repeat
			else if cwd = startup disk then
				error "Go workspace not found" number -43
			end if
			set cwd to (container of (cwd as alias))
		end repeat
		set theGoPath to POSIX path of (cwd as alias)
	end tell
	
	tell application "Finder"
		if not (exists POSIX file "/usr/local/go") then
			error "Go not installed" number -43
		end if
	end tell
	return "PATH=$PATH:/usr/local/go/bin:" & theGoPath & "bin GOPATH=" & theGoPath
	
	return env
end getShellEnv

on run
	tell application "BBEdit" to set theDocument to active document of text window 1
	log POSIX path of (file of theDocument as string)
	try
		set env to getShellEnv(theDocument)
		log env
	on error message number err
		log "Error: " & message & " (" & err & ")"
	end try
end run

on execScript(theScript, theDocument)
	tell application "BBEdit" to set sourceFile to file of theDocument
	tell application "Finder" to set scriptFile to (((my packageRoot) as string) & theScript) as alias
	set sourcePath to quoted form of POSIX path of sourceFile
	set scriptPath to quoted form of POSIX path of scriptFile
	return do shell script (getShellEnv(theDocument) & " BB_DOC_PATH=" & sourcePath & " " & scriptPath)
end execScript

on handleDocumentDidSave(theDocument)
	execScript("Scripts:goimports.sh", theDocument)
	set lintResults to execScript("Scripts:golint.sh", theDocument)
	tell application "BBEdit"
		make new results browser with data {{result_kind:error_kind, result_document:theDocument, start_offset:0, end_offset:100, result_line:-1, message:lintResults}} with properties {name:"golint"}
	end tell
end handleDocumentDidSave
