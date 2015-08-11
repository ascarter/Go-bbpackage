#
# Makefile for Go.bbpackage
#

GOTAGS ?= gotags
GOROOT ?= $(shell go env GOROOT)

SRC_DIR = ./src
PKG = ./Go.bbpackage
CONTENTS_DIR = $(PKG)/Contents

COMPLETION_DIR = $(CONTENTS_DIR)/Completion\ Data/Go
TAGFILE = $(COMPLETION_DIR)/Go\ Standard\ Library.tags

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

test:
	go build test.go

tags: $(TAGFILE)

$(TAGFILE):
	mkdir -p $(COMPLETION_DIR)
	$(GOTAGS) -R \
		--exclude="*_test.go" \
		--exclude="$(GOROOT)/src/*/*/testdata/*" \
		--exclude="$(GOROOT)/src/*/*/testdata/*/*" \
		--exclude="$(GOROOT)/src/*/*/testdata/*/*/*" \
		--exclude="$(GOROOT)/src/*/*/testdata/*/*/*/*" \
		--exclude="$(GOROOT)/src/*/*/testdata/*/*/*/*/*" \
		--exclude="$(GOROOT)/src/*/*/testdata/*/*/*/*/*/*" \
		--exclude="$(GOROOT)/src/*/*/testdata/*/*/*/*/*/*/*" \
		--exclude="$(GOROOT)/src/*/*/*/testdata/*" \
		--exclude="$(GOROOT)/src/internal/*/*" \
		--exclude="$(GOROOT)/src/internal/*/*/*" \
		--exclude="$(GOROOT)/*/internal/*" \
		--exclude="$(GOROOT)/*/internal/*/*" \
		--exclude="$(GOROOT)/*/internal/*/*/*" \
		--exclude="$(GOROOT)/*/internal/*/*/*/*" \
		--exclude="$(GOROOT)/*/*/internal/*" \
		--exclude="$(GOROOT)/*/*/internal/*/*" \
		--exclude="$(GOROOT)/*/*/internal/*/*/*" \
		--exclude="$(GOROOT)/*/*/internal/*/*/*/*" \
		-f=$(TAGFILE) --exclude-private=true $(GOROOT)/src
