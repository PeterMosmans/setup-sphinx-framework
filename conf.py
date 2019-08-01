# -*- coding: utf-8 -*-
# Configuration file for the Sphinx documentation builder.
# Part of the Go Forward Sphinx documentation framework

from __future__ import unicode_literals

import sys


LATEX_STYLING = "_static/latex-styling.tex"
VERSION_FILE = "VERSION"


try:
    with open(LATEX_STYLING, mode="r+") as latex_styling:
        PREAMBLE = latex_styling.read()
except FileNotFoundError:
    print("Could not read {0}".format(LATEX_STYLING), file=sys.stderr)
    PREAMBLE = ""


try:
    with open(VERSION_FILE) as version_file:
        version = version_file.read().strip()
except FileNotFoundError:
    print("Could not read {0}".format(VERSION_FILE), file=sys.stderr)
    version = "0.0.0"
release = version


# This file does only contain a selection of the most common options. For a
# full list see the documentation:
# http://www.sphinx-doc.org/en/master/config

# -- Project information -----------------------------------------------------

project = "Go Forward documentation"
copyright = "2019, Peter Mosmans"
author = "Peter Mosmans"
filename = "GoForwardDocumentation"
description = project


# -- General configuration ---------------------------------------------------

# Add any Sphinx extension module names here, as strings. They can be
# extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
# ones.
extensions = []

# Add a unique prefix per document
autosectionlabel_prefix_document = True

# Add any paths that contain templates here, relative to this directory.
templates_path = ['_templates']

# The suffix(es) of source filenames.
# You can specify multiple suffix as a list of string:
#
# source_suffix = ['.rst', '.md']
source_suffix = '.rst'

# The master toctree document.
master_doc = 'index'

# The language for content autogenerated by Sphinx. Refer to documentation
# for a list of supported languages.
#
# This is also used if you do content translation via gettext catalogs.
# Usually you set "language" from the command line for these cases.
language = None

# List of patterns, relative to source directory, that match files and
# directories to ignore when looking for source files.
# This pattern also affects html_static_path and html_extra_path.
exclude_patterns = []

# The name of the Pygments (syntax highlighting) style to use.
pygments_style = 'monokai'


# -- Options for HTML output -------------------------------------------------

# The theme to use for HTML and HTML Help pages.  See the documentation for
# a list of builtin themes.

html_theme = 'sphinx_rtd_theme'
html_theme_options = {'display_version': True}

# Theme options are theme-specific and customize the look and feel of a theme
# further.  For a list of options available for each theme, see the
# documentation.
#
# html_theme_options = {}

# Add any paths that contain custom static files (such as style sheets) here,
# relative to this directory. They are copied after the builtin static files,
# so a file named "default.css" will overwrite the builtin "default.css".
html_static_path = ['_static']

# Custom sidebar templates, must be a dictionary that maps document names
# to template names.
#
# The default sidebars (for documents that don't match any pattern) are
# defined by theme itself.  Builtin themes are using these templates by
# default: ``['localtoc.html', 'relations.html', 'sourcelink.html',
# 'searchbox.html']``.
#
# html_sidebars = {}


# -- Options for HTMLHelp output ---------------------------------------------

# Output file base name for HTML help builder.
htmlhelp_basename = filename


# -- Options for LaTeX output ------------------------------------------------

latex_elements = {
    'papersize': 'a4paper',
    'pointsize': '10pt',
    'preamble': PREAMBLE
}
latex_engine = 'xelatex'

# Grouping the document tree into LaTeX files. List of tuples
# (source start file, target name, title,
#  author, documentclass [howto, manual, or own class]).
latex_documents = [
    (master_doc, filename + ".tex", project, author, 'manual')
]
latex_logo = "_static/logo.png"

# -- Options for manual page output ------------------------------------------

# One entry per manual page. List of tuples
# (source start file, name, description, authors, manual section).
man_pages = [
    (master_doc, filename, project, author, 1)
]


# -- Options for Texinfo output ----------------------------------------------

# Grouping the document tree into Texinfo files. List of tuples
# (source start file, target name, title, author,
#  dir menu entry, description, category)
texinfo_documents = [
    (master_doc, filename, project,
     author, filename + ".tex", description,
     "Miscellaneous"),
]


# -- Options for Epub output -------------------------------------------------

# Bibliographic Dublin Core info.
epub_title = project
epub_author = author
epub_publisher = author
epub_copyright = copyright

# The unique identifier of the text. This can be a ISBN number
# or the project homepage.
#
# epub_identifier = ''

# A unique identification for the text.
#
# epub_uid = ''

# A list of files that should not be packed into the epub file.
epub_exclude_files = ['search.html']

