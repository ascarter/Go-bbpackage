#
# Makefile for Go.bbpackage
#

GOROOT ?= $(shell go env GOROOT)

SRC_DIR = ./src
PKG = ./Go.bbpackage
PKG_CONTENTS = $(PKG)/Contents

.DEFAULT: help

help:
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

clean: ## Clean built package
	-rm -rf $(PKG)

install: build ## Install package
	open $(PKG)/.

build: $(PKG) ## Build package

release: build ## Create release
	git tag -a 

test: ## Run tests
	go build test.go

$(PKG):
	mkdir -p $(PKG_CONTENTS)
	cp README.md $(PKG)/.
	cp LICENSE $(PKG)/.
	cp -R $(SRC_DIR)/* $(PKG_CONTENTS)/.
	xcrun ibtool $(SRC_DIR)/Resources/go\ doc.xib  --compile $(PKG_CONTENTS)/Resources/go\ doc.xib
	$(PKG_CONTENTS)/scripts/stdlib/Update\ ctags.sh
