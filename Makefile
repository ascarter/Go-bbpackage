#
# Makefile for Go.bbpackage
#

GOTAGS ?= gotags

SRC_DIR = ./src
CONTENTS_DIR = $(SRC_DIR)/Contents
PKG = ./Go.bbpackage

XIBS = $(SRC_DIR)/Resources/godoc.xib
TAGFILE = $(PKG)/Contents/Completion\ Data/Go/Go\ Standard\ Library.tags

.DEFAULT: all

.PHONY: all clean install tags ctags test

all: build tags

clean:
	-rm -rf $(PKG)

install: all
	open $(PKG)/.

build: $(PKG)
	
$(PKG):
	mkdir -p $(PKG)
	cp README.md $(PKG)/.
	cp LICENSE $(PKG)/.
	cp -R $(CONTENTS_DIR) $(PKG)/.

test:
	go build test.go

tags: $(TAGFILE)

$(TAGFILE):
	mkdir -p $(PKG)/Contents/Completion\ Data/Go
	$(GOTAGS) -R \
		--exclude="*_test.go" \
		--exclude="/usr/local/go/src/*/*/testdata/*" \
		--exclude="/usr/local/go/src/*/*/testdata/*/*" \
		--exclude="/usr/local/go/src/*/*/testdata/*/*/*" \
		--exclude="/usr/local/go/src/*/*/testdata/*/*/*/*" \
		--exclude="/usr/local/go/src/*/*/testdata/*/*/*/*/*" \
		--exclude="/usr/local/go/src/*/*/testdata/*/*/*/*/*/*" \
		--exclude="/usr/local/go/src/*/*/testdata/*/*/*/*/*/*/*" \
		--exclude="/usr/local/go/src/*/*/*/testdata/*" \
		-f=$(TAGFILE) --exclude-private=true $(GOROOT)/src
