#
# Makefile for Go.bbpackage
#

SOURCES := \
	src/Resources/package.applescript

OBJECTS := $(SOURCES:src/%.applescript=Contents/%.scpt)

Contents/%.scpt : src/%.applescript
	osacompile -o "$(subst _, ,$@)" "$<"

.DEFAULT: all

.PHONY: all clean install

all: $(OBJECTS)

clean:
	-rm -f $(subst _,\ ,$(OBJECTS))

install: all
	open .
