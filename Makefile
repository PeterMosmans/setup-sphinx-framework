# Minimal makefile for Sphinx documentation
# Part of the Go Forward Sphinx documentation framework

# You can set these variables from the command line.
SPHINXOPTS    =
SPHINXBUILD   = sphinx-build
SOURCEDIR     = .
BUILDDIR      = _build
RELEASEDIR    = releases
# The version tag will be read from the file VERSION
VERSION       = $(shell cat VERSION)
# The filename will be read from the configuration file
FILENAME      = $(shell awk -F"[\x27\x22]" '/filename[ ]*=/{print $$2}' $(SOURCEDIR)/conf.py)

# Put it first so that "make" without argument is like "make html".
html:	showversion
	@$(SPHINXBUILD) -M html "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: help Makefile showversion

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

devserver: html
	# Find out if a TTY (terminal) is used or not
	@if [ -t 1 ]; then \
	  winpty sphinx-autobuild --port $(PORT) source build/html --re-ignore ".*/\.#*" -B; \
	else \
	  sphinx-autobuild --port $(PORT) source build/html --ignore ".*\.\#*" -B; \
	fi

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

