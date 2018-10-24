# Minimal makefile for Sphinx documentation
# Part of the Go Forward Sphinx documentation framework

# You can set these variables from the command line.
SPHINXOPTS    =
SPHINXBUILD   = sphinx-build
SOURCEDIR     = source
BUILDDIR      = build

# Put it first so that "make" without argument is like "make html".
html:
	@$(SPHINXBUILD) -M html "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: help Makefile

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

pdf:
	@$(SPHINXBUILD) -b latex "$(SOURCEDIR)" "$(BUILDDIR)/latex" $(SPHINXOPTS) $(O)
	$(MAKE) -C "$(BUILDDIR)/latex"
	@mkdir -p "$(BUILDDIR)/pdf"
	@mv "$(BUILDDIR)/latex"/*.pdf "$(BUILDDIR)/pdf/"
	@echo -n "PDF can be found at "
	@ls "$(BUILDDIR)/pdf"/*.pdf
