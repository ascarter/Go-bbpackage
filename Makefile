#
# Makefile for Go.bbpackage
#

GOROOT ?= $(shell go env GOROOT)

SRC_DIR := ./src
PKG := ./Go.bbpackage
PKG_CONTENTS := $(PKG)/Contents
PKG_ZIP = $(PKG)-$(TAG).zip

TAG := $(or $(shell hub release --limit 1 --format "%T"),v1.0.0)

# semver <part>
# 1 = major
# 2 = minor
# 3 = patch
semver = $(shell echo $(TAG) | sed -E "s/v([0-9]+)[.]([0-9]+)[.]([0-9]+)/\$(1)/")

# Increment $1 by 1
increment = $(shell echo $$(($(1)+1)))

# Set version parts
MAJOR := $(call semver,1)
MINOR := $(call semver,2)
PATCH := $(call semver,3)

.DEFAULT: help

help:
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

clean: ## Clean built package
	-rm -rf $(PKG) $(PKG_ZIP)

install: build ## Install package
	open $(PKG)/.

build: $(PKG) ## Build package

major: TAG = v$(call increment,$(MAJOR)).$(MINOR).$(PATCH)
major: release

minor: TAG = v$(MAJOR).$(call increment,$(MINOR)).$(PATCH)
minor: release

patch: TAG = v$(MAJOR).$(MINOR).$(call increment,$(PATCH))
patch: release

release: $(PKG_ZIP) ## Create release
	$(info Creating release $(TAG))
	hub release create --browse --draft --attach $< --edit --message "Go-bbpackage $(TAG)" $(TAG)

test: ## Run tests
	go build test.go

$(PKG):
	mkdir -p $(PKG_CONTENTS)
	cp README.md $(PKG)/.
	cp LICENSE $(PKG)/.
	cp -R $(SRC_DIR)/* $(PKG_CONTENTS)/.
	xcrun ibtool $(SRC_DIR)/Resources/go\ doc.xib  --compile $(PKG_CONTENTS)/Resources/go\ doc.xib
	$(PKG_CONTENTS)/scripts/stdlib/Update\ ctags.sh

$(PKG_ZIP): $(PKG)
	zip -r $@ $^
	