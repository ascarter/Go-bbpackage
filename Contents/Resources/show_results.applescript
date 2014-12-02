#! /usr/bin/osascript

# Display runner results in BBEdit Results Browser
#
# Expected arguments:
#   title    -- tile for results browser
#	doc      -- path to document
#   messages -- sorted list of messages
on run argv
	if (count of argv) < 3 then
		error "Usage: bbresults [title] [doc] [messages]"
	end if
	
	set title to ((item 1 of argv) as string)
	set doc to POSIX file ((item 2 of argv) as string)
	set messages to (item 3 of argv)
	
	tell application "Finder"
		set resources to (container of (path to me)) as string
		set golib to load script ((resources & "package.scpt") as alias)
		tell golib to showResults(title, doc, messages)
	end tell
	
	return
end run