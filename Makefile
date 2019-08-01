# Minimal makefile for Sphinx documentation
# Part of the Go Forward Sphinx documentation framework

# You can set these variables from the command line.
SPHINXOPTS    =
SPHINXBUILD   = sphinx-build
SOURCEDIR     = .
BUILDDIR      = _build
DEPLOYDIR     = ../../deploy
RELEASEDIR    = releases
PORT          = 8080
# The version tag will be read from the file VERSION
VERSION       = $(shell cat VERSION)
# The filename will be read from the configuration file
FILENAME      = $(shell awk -F"[\x27\x22]" '/filename[ ]*=/{print $$2}' $(SOURCEDIR)/conf.py)

# Put it first so that "make" without argument is like "make html".
html:	showversion
	@$(SPHINXBUILD) -M html "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: help Makefile showversion

bumpmajor: VERSION
	semver bump major $(shell cat VERSION) > VERSION

bumpminor: VERSION
	semver bump minor $(shell cat VERSION) > VERSION

bumppatch: VERSION
	semver bump patch $(shell cat VERSION) > VERSION

clean:
	rm -rf $(BUILDDIR)/html

deploy: clean html
	cp -r $(BUILDDIR)/html/* $(DEPLOYDIR)
	cd $(DEPLOYDIR) && git add * && git pull && git commit -m "Deploy version $(VERSION)" && git push

help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

devserver: html
	# Find out if a TTY (terminal) is used or not
	@if [ -t 1 ]; then \
	  winpty sphinx-autobuild --port $(PORT) $(SOURCEDIR) $(BUILDDIR)/html --re-ignore ".*/\.#*" -B; \
	else \
	  sphinx-autobuild --port $(PORT) $(SOURCEDIR) $(BUILDDIR)/html --ignore ".*\.\#*" -B; \
	fi

final: showversion
	@$(SPHINXBUILD) -M html "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) -t final $(O)

handouts:
	for i in ../slidedecks/*.odp; do \
	  pptxtopdf.py $$i --output source/_static ; \
	done

pdf:	showversion
	@$(SPHINXBUILD) -b latex "$(SOURCEDIR)" "$(BUILDDIR)/latex" $(SPHINXOPTS) $(O)
	$(MAKE) -C "$(BUILDDIR)/latex"
	@mkdir -p "$(BUILDDIR)/pdf"
	@mv "$(BUILDDIR)/latex/$(FILENAME).pdf" "$(BUILDDIR)/pdf/$(FILENAME).pdf"
	@echo "PDF can be found at $(BUILDDIR)/pdf/$(FILENAME).pdf"

release: pdf
	@mkdir -p $(RELEASEDIR) &>/dev/null
	@cp --update "$(BUILDDIR)/pdf/$(FILENAME).pdf" "$(RELEASEDIR)/$(FILENAME)-$(VERSION).pdf"
	@echo "PDF release $(VERSION) can be found at $(RELEASEDIR)/$(FILENAME)-$(VERSION).pdf"

showversion:
	@echo "Building version $(VERSION)"

