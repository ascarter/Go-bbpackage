#
# Makefile for Go.bbpackage
#

GOROOT ?= $(shell go env GOROOT)

SRC_DIR = ./src
PKG = ./Go.bbpackage
CONTENTS_DIR = $(PKG)/Contents

COMPLETION_DIR = $(CONTENTS_DIR)/Completion\ Data/Go
TAGOBJ := ./gostdlib.tags
TAGFILE := $(COMPLETION_DIR)/Go\ Standard\ Library.tags
CTAGS ?= /Applications/BBEdit.app/Contents/Helpers/ctags
CTAGS_ARGS = --recurse --extra=+p+q+r --fields=+a+m+n+S --excmd=number --tag-relative=no --sort=no \
	--exclude=.git --exclude="*_test.go" --exclude="**/testdata/**" --exclude="**/internal/**"

.DEFAULT: all

.PHONY: all clean install tags ctags test

all: build tags

clean:
	-rm -rf $(PKG)

install: all
	open $(PKG)/.

build: $(PKG)

$(PKG):
	mkdir -p $(CONTENTS_DIR)
	cp README.md $(PKG)/.
	cp LICENSE $(PKG)/.
	cp -R $(SRC_DIR)/* $(CONTENTS_DIR)/.
	xcrun ibtool $(SRC_DIR)/Resources/go\ doc.xib  --compile $(CONTENTS_DIR)/Resources/go\ doc.xib	

test:
	go build test.go

tags: $(TAGFILE)

$(TAGFILE):
	$(CTAGS) $(CTAGS_ARGS) -f - $(GOROOT)/src | grep -v -E '^(\w+[.])?[^A-Z]\w+\s+\S+\s\d+[;]["]\s+[cfimstv]' > $(TAGOBJ)
	mkdir -p $(COMPLETION_DIR)
	mv $(TAGOBJ) $(TAGFILE)
