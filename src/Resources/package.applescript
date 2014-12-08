-- Go AppleScript library

property package : "Go"
property packageRoot : missing value
property results : {}

-- Get working directory for a given document
on getWorkingDirectory(doc)
	tell application "Finder"
		return POSIX path of ((container of ((file of doc) as alias) as string))
	end tell
end getWorkingDirectory

-- Find Go.bbpackage root
-- Assumption: this is *always* run from within the package!
on getPackageRoot()
	tell application "Finder"
		set cwd to ((container of (path to me)) as alias)
		repeat until name of cwd is "Go.bbpackage"
			set cwd to (container of cwd as alias)
		end repeat
	end tell
	return POSIX path of (cwd as string)
end getPackageRoot

on execStdIn(input, cmd)
	set prevDelimiter to AppleScript's text item delimiters
	set AppleScript's text item delimiters to {ASCII character 10}
	set output to do shell script ("echo " & quoted form of (input as string) & " | " & cmd)
	set AppleScript's text item delimiters to {ASCII character 13}
	set outputList to paragraphs of output
	set AppleScript's text item delimiters to prevDelimiter
	return outputList
end execStdIn

on execGoRunner(doc, prefix, cmd)
	tell application "BBEdit"
		if source language of doc is not "Go" then
			error "Not a Go source file"
		end if
	end tell
	
	if packageRoot is missing value then
		set packageRoot to getPackageRoot()
	end if
	
	set runner to quoted form of (POSIX path of (packageRoot as string) & "Contents/Resources/gorunner")
	set envVars to "BB_DOC_PATH=" & POSIX path of ((file of doc) as alias)
	set shellCmd to envVars & space & runner & space & cmd
	if prefix is not missing value then
		set shellCmd to prefix & " | " & shellCmd
	end if
	return do shell script (shellCmd)
end execGoRunner

on execCommand(doc, cmd)
	return execGoRunner(doc, missing value, cmd)
end execCommand

on execCommandWithPrefix(doc, prefix, cmd)
	return execGoRunner(doc, prefix, cmd)
end execCommandWithPrefix

on execCommands(doc, commands)
	set output to {}
	repeat with cmd in commands
		try
			set entry to execCommand(doc, cmd)
			if length of entry > 0 then
				copy entry to the end of output
			end if
		on error msg
			if length of msg > 0 then
				copy msg to the end of output
			end if
		end try
	end repeat
	return output
end execCommands

on packagePath(doc)
	return quoted form of execCommand(doc, "go list")
end packagePath

-- Echo doc contents
on echoContents(doc)
	set prevDelimiter to AppleScript's text item delimiters
	set AppleScript's text item delimiters to {ASCII character 10}
	set output to "echo " & quoted form of ((lines of doc) as string)
	log output
	set AppleScript's text item delimiters to prevDelimiter
	--return paragraphs of filteredString
	return output
end echoContents

-- Parse message into result browser entry
--
-- Format:
--     [/path/to/file]:[line]:(col): [message]
on makeEntry(itemData, doc, cwd)
	try
		-- Get source path
		set src to text 1 thru ((offset of ":" in itemData) - 1) of itemData
		log src
		if src starts with "./" then
			set srcFile to POSIX file (cwd & text 3 thru -1 of src)
		else if src starts with "/" then
			set srcFile to POSIX file (src)
		else if src starts with "<standard input>" then
			set srcFile to POSIX path of doc
			
		else
			set srcFile to POSIX file (cwd & text 1 thru -1 of src)
		end if
		
		-- Get line:column
		set lineColumn to text ((offset of ":" in itemData) + 1) thru ((offset of ": " in itemData) - 1) of itemData
		if lineColumn contains "." and lineColumn contains "-" then
			-- line.col-line.col
			set lineNumber to (text 1 thru ((offset of "." in lineColumn) - 1) of lineColumn) as number
			set columnNumber to (text ((offset of "." in lineColumn) + 1) thru ((offset of "-" in lineColumn) - 1) of lineColumn) as number
		else
			-- line:col
			set lineNumber to (text 1 thru ((offset of ":" in lineColumn) - 1) of lineColumn) as number
			set columnNumber to (text ((offset of ":" in lineColumn) + 1) thru -1 of lineColumn) as number
		end if
		
		-- Get message
		set msg to text ((offset of ": " in itemData) + 2) thru -1 of itemData
		
		tell application "BBEdit"
			set resultKind to error_kind
			
			-- TODO: Improve filter for warnings vs errors
			if "should" is in msg then
				set resultKind to warning_kind
			end if
			
			--	if resultType is "note" then
			--		set resultKind to note_kind
			--	else if resultType is "warning" then
			--		set resultKind to warning_kind
			--	else
			--		set resultKind to error_kind
			--	end if
			
			set entry to {result_kind:resultKind, result_file:srcFile, result_line:lineNumber, message:msg}
		end tell
		return entry
	on error msg
		log "Error: " & msg
		return missing value
	end try
end makeEntry

on showResults(title, doc, messages)
	tell application "Finder"
		set cwd to POSIX path of ((container of (doc as alias) as string))
		set docName to name of (doc as alias)
	end tell
	
	-- Normalize any file names
	set sedString to "s/([<]*[>])'/" & docName & "/g"
	set msgString to execStdIn(messages, "sed " & quoted form of sedString)
	
	-- Filter invalid entries
	
	-- Sort & unique
	set msgString to execStdIn(msgString, "sort -f | uniq")
	log msgString
	set errorList to {}
	
	repeat with msg in msgString
		if msg does not start with "#" and msg does not start with "exit status" then
			set entry to makeEntry(msg, doc, cwd)
			if entry is not missing value then
				copy entry to the end of errorList
			end if
		end if
	end repeat
	
	if (count of errorList) > 0 then
		try
			tell application "BBEdit"
				make new results browser with data errorList with properties {name:title}
			end tell
		on error msg
			log "Error: " & msg
		end try
	end if
end showResults

on documentWillSave(doc)
	return
	try
		set docPath to POSIX path of ((file of doc) as string)
		set output to execCommandWithPrefix(doc, echoContents(doc), "goimports")
		if output is not missing value then
			tell application "BBEdit"
				set contents of doc to output
			end tell
		end if
	on error msg
		set results to results & msg
		--showResults("goimports " & (name of doc), POSIX file (docPath), msg)
	end try
end documentWillSave

on documentDidSave(doc)
	return
	try
		set docPath to POSIX path of ((file of doc) as string)
		--set pkgPath to packagePath(doc)
		set goCommands to {"golint " & quoted form of docPath, "go vet " & quoted form of docPath}
		set output to execCommands(doc, goCommands)
		if output is not missing value then
			set results to results & output
			--showResults("golint " & (name of doc), POSIX file (docPath), output)
		end if
	on error msg
		log "Error documentDidSave: " & msg
	end try
	if length of results > 0 then
		showResults("Save", POSIX file (docPath), results)
	end if
end documentDidSave

on run
	tell application "BBEdit" to set doc to active document of window 1
	documentWillSave(doc)
	documentDidSave(doc)
end run
