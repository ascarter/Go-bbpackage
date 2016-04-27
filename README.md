BBEdit package for Go development

Features
--------

* Full language syntax highlighting
* Support for code folding `func`
* Language defaults
* Full set of clippings
* Go tool scripts
* Completion data for Go standard library

The package is a collection of BBEdit supporting elements for developing Go applications. The `Resources` directory contains the toolset for supporting the scripting and integration.

The shell scripts utilize a snapshot of [gows](https://github.com/ascarter/gows) which is a workspace manager that can detect the Go workspace and run commands within that workspace. The scripts also uses a snapshot of [bbresults](https://github.com/ascarter/dotfiles/blob/master/src/bin/bbresults). This is a Ruby script that accepts formatted records on `stdin` and displays them in a results browser window in BBEdit. It is useful for lint or build tools to output results in BBEdit in an easy to use form. 

## Requirements

The following are required for using Go.bbpackage:

* [BBEdit](http://barebones.com/products/bbedit) 11.1 or greater
* [Go](https://golang.org/dl/) 1.5 or greater

## Optional components:

### ctags

A completion library is can be built using [Universal Ctags](https://ctags.io/). This is a  modern maintained version of [Exuberant Ctags](http://ctags.sourceforge.net/). It includes support for Go.

The easiest way to install it is to use homebrew:

    brew tap universal-ctags/universal-ctags
    brew install --HEAD universal-ctags

The following is a recommended `~/.ctags` configuration:

    --exclude=.git
    --extra=+p+q+r
    --fields=+a+m+n+S
    --sort=no

To build a tags library for the Go standard library, run the following target (run by default):

    make tags

## Build

To build `Go.bbpackage`:

* [Xcode](https://developer.apple.com/xcode/) 6 or greater (particularly the command line tools package)
* [Universal Ctags](https://ctags.io/)

## Install

The package should be cloned into a working directory. The `Makefile` will build the sources. The `install` task will install the package to the correct `Application Support` directory (either in `$HOME/Dropbox/Application Support/BBEdit` or `$HOME/Library/Application Support/BBEdit`).

        git clone https://github.com/ascarter/Go-bbpackage.git
        cd Go-bbpackage
        make install

## Update

Pull changes and run make install again:

        cd Go-bbpackage
        git pull
        make clean install

## Usage

The best way to use BBEdit with a Go project is to simply launch BBEdit from the project root.

        cd ~/Projects/workspace/src/github.com/<username>/<my cool project>
        bbedit .

