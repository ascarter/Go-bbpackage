#
# Makefile for Go.bbpackage
#

CTAGS = /Applications/BBEdit.app/Contents/Helpers/ctags

XIBS := src/Resources/godoc.xib
XIBOBJS := $(XIBS:src/Resources/%.xib=Contents/Resources/%.xib)

TAGOBJ := ./gostdlib.tags
TAGFILE := Contents/Completion\ Data/Go/Go\ Standard\ Library.tags

.DEFAULT: all

.PHONY: all clean install xibs

all: $(TAGFILE) xibs

clean:
	-rm -f $(TAGOBJ)
	-rm -f $(TAGFILE)
	-rm -f $(XIBOBJS)

install: all
	open .

xibs:
	#xcrun ibtool src/Resources/godoc.xib --compile Contents/Resources/godoc.xib
	cp src/Resources/godoc.xib Contents/Resources/godoc.xib
	
$(TAGFILE):
	$(CTAGS) --recurse --langdef=GoStdLib --langmap=GoStdLib:.go \
		--regex-GoStdLib="/func([ \t]+\([^)]+\))?[ \t]+([A-Z][a-zA-Z0-9_]+)/\2/f,func/" \
		--regex-GoStdLib="/var[ \t]+([A-Z][a-zA-Z0-9_]+)/\1/v,var/" \
		--regex-GoStdLib="/type[ \t]+([A-Z][a-zA-Z0-9_]+)/\1/t,type/" \
		--regex-GoStdLib="/^package[ \t]+([a-zA-Z_][a-zA-Z0-9_]+)/\1/p,package/" \
		--regex-GoStdLib="/const[ \t]+([A-Z][a-zA-Z0-9_]+)[ \t]+.*\=[ \t]+(.*)/\1/d,constant/" \
		--languages=GoStdLib --fields=+a+m+n+S --excmd=number --tag-relative=no \
		--exclude="*_test.go" -f $(TAGOBJ) $(GOROOT)/src
	mkdir -p Contents/Completion\ Data/Go
	mv $(TAGOBJ) $(TAGFILE)
