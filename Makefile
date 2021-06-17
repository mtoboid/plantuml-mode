SHELL = /bin/sh

#
# Programs used in the make goals
#
export CASK  ?= cask
export EMACS ?= emacs

#
# General configuration
#
export CASK_DIR            ?= `${CASK} package-directory`
export BATCH                = --batch -q -l .emacs/init.el
export COVERALLS_REPO_TOKEN = 61YFD7RG1RRJTs0kEuj1aZX7VBgUPiMNO

#
# PlantUML
#
plantuml = bin/plantuml.jar
download_plantuml_jar = bin/download-plantuml.sh

all: version test

$(plantuml):
	$(download_plantuml_jar)

version:
	$(EMACS) $(BATCH) --version

test: install unit

unit: $(plantuml)
	${CASK} exec ert-runner

install:
	${CASK} install

clean:
	rm -f $(plantuml)
	rm -Rf .emacs.d
	rm -Rf .cask

.PHONY: all test unit install clean
