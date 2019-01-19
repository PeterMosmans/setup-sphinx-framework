#!/usr/bin/env bash

# setup_sphinx_framework - Sets up Sphinx framework
# Part of the Go Forward Sphinx documentation framework
#
# Copyright (C) 2018-2019 Peter Mosmans [Go Forward]
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# Define an associative array
declare -A copyfiles

# Files to copy
copyfiles=(
    [.]=".gitignore conf.py Makefile VERSION"
    [_static]="latex-styling.tex logo.png"
    )

# Directories to create
createdirectories="_static _templates"

# Files to create
createfiles="index.rst"

## Don't change anything below this line
source=$(dirname $(readlink -f $0))
target=$1

if [ -z "$target" ]; then
    target=$(readlink -f .)
    # Check whether the script is being executed from within the source directory
    if [ "${target}" == "${source}" ]; then
        echo "Usage: installer [TARGET]"
        echo "       or run from within target directory"
        exit
    fi
fi

echo "[*] Applying changes (if any)..."
for directory in ${createdirectories}; do
    mkdir -p ${target}/${directory}
done

for targetdirectory in "${!copyfiles[@]}"; do
    for file in ${copyfiles[$targetdirectory]}; do
        # Never overwrite existing files
        cp -nv ${source}/${targetdirectory}/${file} ${target}/${targetdirectory}/${file}
    done
done

for file in ${createfiles}; do
    if [ ! -f ${target}${file} ]; then
        touch ${target}/${file}
    fi
done

echo "[+] Done"
