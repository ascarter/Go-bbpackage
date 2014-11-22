-- Go AppleScript library

property package : "Go"
property packageRoot : missing value

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

on exec(doc, cmd)
	tell application "BBEdit"
		if source language of doc is not "Go" then
			error "Not a Go source file"
		end if
	end tell
	
	if packageRoot is missing value then
		set packageRoot to getPackageRoot()
	end if
	
	set runner to quoted form of (POSIX path of (packageRoot as string) & "Contents/Resources/gorunner")
	set shellCmd to runner & space & "-d " & POSIX path of ((file of doc) as alias) & space & cmd
	return do shell script (shellCmd)
end exec

on execCommands(doc, commands)
	set output to {}
	repeat with cmd in commands
		set entry to exec(doc, cmd)
		if length of entry > 0 then
			copy entry to the end of output
		end if
	end repeat
	return output
end execCommands

on packagePath(doc)
	return quoted form of exec(doc, "go list")
end packagePath

# Parse message into result browser entry
#
# Format:
#     [/path/to/file]:[line]:(col): [message]
on makeEntry(itemData, cwd)
	try
		# Get source path
		set src to text 1 thru ((offset of ":" in itemData) - 1) of itemData
		if src starts with "./" then
			set srcFile to POSIX file (cwd & text 3 thru -1 of src)
		else
			set srcFile to POSIX file (src)
		end if
		
		# Get line:column
		set lineColumn to text ((offset of ":" in itemData) + 1) thru ((offset of ": " in itemData) - 1) of itemData
		set lineNumber to (text 1 thru ((offset of ":" in lineColumn) - 1) of lineColumn) as number
		set columnNumber to (text ((offset of ":" in lineColumn) + 1) thru -1 of lineColumn) as number
		
		# Get message
		set msg to text ((offset of ": " in itemData) + 2) thru -1 of itemData
		
		tell application "BBEdit"
			set resultKind to error_kind
			#	if resultType is "note" then
			#		set resultKind to note_kind
			#	else if resultType is "warning" then
			#		set resultKind to warning_kind
			#	else
			#		set resultKind to error_kind
			#	end if
			
			set entry to {result_kind:resultKind, result_file:srcFile, result_line:lineNumber, message:msg}
		end tell
		return entry
	on error msg
		log "Error: " & msg
		return missing value
	end try
end makeEntry

-- Filter and sort incoming messages
on prepareMessages(messages)
	set prevDelimiter to AppleScript's text item delimiters
	set AppleScript's text item delimiters to {ASCII character 10}
	set filteredString to do shell script ("echo " & quoted form of (messages as string) & " | sort -f | uniq")
	set AppleScript's text item delimiters to prevDelimiter
	return paragraphs of filteredString
end prepareMessages

on showResults(title, doc, messages)
	tell application "Finder"
		set cwd to POSIX path of ((container of (doc as alias) as string))
	end tell
	
	set errorList to {}
	set messageList to prepareMessages(messages)
	
	repeat with msg in messageList
		if msg does not start with "#" then
			set entry to makeEntry(msg, cwd)
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

on handleDocumentDidSave(doc)
	try
		set docPath to POSIX path of ((file of doc) as string)
		set pkgPath to packagePath(doc)
		set goCommands to {"goimports -w " & quoted form of docPath, "golint " & quoted form of docPath, "go build", "go test"}
		set output to execCommands(doc, goCommands)
		if output is not missing value then
			showResults("Save " & (name of doc), POSIX file (docPath), output)
		end if
	on error msg
		log "Error handleDocumentDidSave: " & msg
	end try
end handleDocumentDidSave

(*
on run
	tell application "BBEdit" to set doc to active document of window 1
	handleDocumentDidSave(doc)
end run
*)
