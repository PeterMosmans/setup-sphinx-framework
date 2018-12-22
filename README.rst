###############################################
Setting Up a New Sphinx Documentation Framework
###############################################

When having to write documentation for different formats, I always use the
reStructuredText_ (or reST) format. As this is something that happens quite
often, it made sense to put some effort in automating the set up of a new
documentation framework, a reusable set up script.

The standard documentation framework that I use consists of `Sphinx`_, which
takes care of converting source pages written in :abbr:`reST (reStructuredText)`
into several formats: For example HTML, but also PDF or something more exotic
like ePub files. Note that Sphinx already comes with a setup script,
`sphinx-quickstart`_ - but this doesn't take care of deploying files.

In order to be able to create a reusable framework, I split the necessary files
into three groups:

+ The Sphinx configuration itself,
+ version information, and
+ a LaTeX formatting template.


The Sphinx configuration
========================

This part consists of two different files; A generic :code:`Makefile` to build
the different artifact types - as well as a Sphinx configuration file
(:code:`conf.py`) containing basic information about the project, and plugin
details. These files rarely change after having initialized the framework.


Version information
===================

The version information (version, or build number) can change per release, and
is therefore contained in a separate text file (:code:`VERSION`). Its values
will be read and included by the build process.


LaTeX template
==============

Thirdly, the LaTex formatting template contains styling information that will be
used when building PDF files, and is also stored in a separate file. This allows
for easy updating and different re-use across projects.


Setting up the framework
========================

The reusable framework consists of a collection of the files mentioned above, as
well as some basic static files.

So all that's left when setting up a new documentation framework is creating
some directories, copying the files, and... that's basically it.

In order to take care of this, I wrote a simple Bash installer script,
:code:`installer.sh`. A new feature in Bash version 4 is the
support of associative arrays. That functionality makes it easier to write a
generic, reusable script which takes care of creating and copying files and
directories.

A simple

.. code-block:: console

   ./installer.sh TARGET

will set up the framework in the directory :code:`TARGET`. Of course the
prerequisites (Sphinx and GNU Make) need to be installed as well. If they are,
all that's left to do is write some content in `reStructuredText`_, and let
`Sphinx`_ build it into an artifact of your choosing, for example HTML:

.. code-block:: console

   make html



.. target-notes::

.. _reStructuredText: http://docutils.sourceforge.net/rst.html
.. _Sphinx: http://www.sphinx-doc.org
.. _`sphinx-quickstart`: http://www.sphinx-doc.org/en/master/man/sphinx-quickstart.html

