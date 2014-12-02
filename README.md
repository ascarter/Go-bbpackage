Go language for BBEdit
=======================

Go support for BBEdit.

Features
--------

* Full language syntax highlighting
* Func support for folding and listing
* Language defaults
* Full set of clippings
* Integration scripts
* Support for documentDidSave events
* Completion data for Go standard library

The package is a collection of BBEdit supporting elements for developing Go applications. The `Resources` directory contains the toolset for supporting the scripting and integration.

There is an AppleScript library that has a collection of methods that can be used by scripts for interacting with BBEdit and Go. For example, handlers for document events are available as well as convenience methods for displaying data in the results browser.

The shell scripts utilize a snapshot of [goenv](https://github.com/ascarter/goenv) which is a workspace manager that can detect the Go workspace and run commands within that workspace. The best way to use BBEdit with a Go project is to simply launch BBEdit from the project root.

        cd ~/gows/src/github.com/<username>/<my cool project>
        bbedit .

## Install

The package should be cloned into a working directory. The `Makefile` will build the AppleScript sources into compiled scripts. The `install` task will install the package to the correct Application Support directory.

        git clone https://github.com/ascarter/Go.bbpackage.git
        cd Go.bbpackage
        make install

## Update

Pull changes and run make install again:

        cd Go.bbpackage
        git pull
        make install

## Support for Document attachment scripts

The package AppleScript library has a handler for `documentDidSave` event. To utilize this, an AppleScript needs to be added to `../Application Support/BBEdit/Attachment Scripts/Document.scpt`. This script should load the library and then call the `handleDocumentDidSave` method.

For a complete example, see [this](https://github.com/ascarter/BBEditSupport/blob/master/Attachment%20Scripts/Document.applescript) script. There are other useful tools in this repository as well.

