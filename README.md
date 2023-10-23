BBEdit package for Go development

> This project is no longer necessary. BBEdit now has full support for Language Server Protocol (LSP) which eliminates the need for custom syntax module. I no longer use this package. See Bare Bones [support page for LSP](https://www.barebones.com/support/bbedit/lsp-notes.html) for instructions on how to install Go's LSP server.


Features
--------

* Full language syntax highlighting
* Support for code folding `func`
* Language defaults
* Full set of clippings
* Go tool scripts
* Completion data for Go standard library

The package is a collection of BBEdit supporting elements for developing Go applications. The `Resources` directory contains the toolset for supporting the scripting and integration.

## Requirements

The following are required for using Go.bbpackage:

* [BBEdit](http://barebones.com/products/bbedit) 12.0 or greater
* [Go](https://golang.org/dl/) 1.8 or greater
* [Xcode](https://developer.apple.com/xcode/) 6 or greater (particularly the command line tools package)

## Install

Download the [latest release](https://github.com/ascarter/Go-bbpackage/releases/latest) and install with BBEdit.

## Build

The package should be cloned into a working directory. The `Makefile` will build the sources. The `install` task will install the package to the correct `Application Support` directory (either Dropbox, iCloud Drive, or `~/Library`).

        git clone https://github.com/ascarter/Go-bbpackage.git
        cd Go-bbpackage
        make install

To update, pull changes and run make install again:

        cd Go-bbpackage
        git pull
        make clean install

## Usage

The best way to use BBEdit with a Go project is to simply launch BBEdit from the project root.

        cd ~/Projects/workspace/src/github.com/<username>/<my cool project>
        bbedit .

## Go version update

For new versions of Go, the package should generally work. The standard library tags can be updated by using the script `stdlib/Update ctags`
