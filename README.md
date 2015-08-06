BBEdit package for Go development

Features
--------

* Full language syntax highlighting
* Func support for folding and listing
* Language defaults
* Full set of clippings
* Integration scripts
* Completion data for Go standard library

The package is a collection of BBEdit supporting elements for developing Go applications. The `Resources` directory contains the toolset for supporting the scripting and integration.

The shell scripts utilize a snapshot of [gows](https://github.com/ascarter/gows) which is a workspace manager that can detect the Go workspace and run commands within that workspace. The scripts also uses a snapshot of [bbresults](https://github.com/ascarter/dotfiles/blob/master/src/bin/bbresults). This is a Ruby script that accepts formatted records on `stdin` and displays them in a results browser window in BBEdit. It is useful for lint or build tools to output results in BBEdit in an easy to use form.

The best way to use BBEdit with a Go project is to simply launch BBEdit from the project root.

        cd ~/gows/src/github.com/<username>/<my cool project>
        bbedit .

## Install

The package should be cloned into a working directory. The `Makefile` will build the sources. The `install` task will install the package to the correct `Application Support` directory (either in `$HOME/Dropbox/Application Support/BBEdit` or `$HOME/Library/Application Support/BBEdit`).

        git clone https://github.com/ascarter/Go-bbpackage.git
        cd Go-bbpackage
        make install

## Update

Pull changes and run make install again:

        cd Go-bbpackage
        git pull
        make install
