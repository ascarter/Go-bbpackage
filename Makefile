#
# Makefile for Go.bbpackage
#

CTAGS = /Applications/BBEdit.app/Contents/Helpers/ctags

SOURCES := \
	src/Resources/package.applescript

OBJECTS := $(SOURCES:src/%.applescript=Contents/%.scpt)

Contents/%.scpt : src/%.applescript
	osacompile -o "$(subst _, ,$@)" "$<"

TAGOBJ := ./gostdlib.tags
TAGFILE := Contents/Completion\ Data/Go/Go\ Standard\ Library.tags

.DEFAULT: all

.PHONY: all clean install

all: $(OBJECTS) tags

clean:
	-rm -f $(subst _,\ ,$(OBJECTS))
	-rm -f $(TAGOBJ)
	-rm -f $(TAGFILE)

install: all
	open .

# Run BBEdit maketags on Go standard library (exported classes only)
tags:
	$(CTAGS) --recurse --langdef=GoStdLib --langmap=GoStdLib:.go \
		--regex-GoStdLib="/func([ \t]+\([^)]+\))?[ \t]+([A-Z][a-zA-Z0-9_]+)/\2/f,func/" \
		--regex-GoStdLib="/var[ \t]+([A-Z][a-zA-Z0-9_]+)/\1/v,var/" \
		--regex-GoStdLib="/type[ \t]+([A-Z][a-zA-Z0-9_]+)/\1/t,type/" \
		--regex-GoStdLib="/^package[ \t]+([a-zA-Z_][a-zA-Z0-9_]+)/\1/p,package/" \
		--regex-GoStdLib="/const[ \t]+([A-Z][a-zA-Z0-9_]+)[ \t]+.*\=[ \t]+(.*)/\1/d,constant/" \
		--languages=GoStdLib --fields=+a+m+n+S --excmd=number --tag-relative=no \
		--exclude="*_test.go" -f $(TAGOBJ) $(GOROOT)/src/pkg
	mv $(TAGOBJ) $(TAGFILE)
