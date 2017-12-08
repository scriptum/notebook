#!/bin/bash

set -e

FILE=${1:-example.tex}

mkdir -p tmp
NUM_VERSIONS=$(awk -F'[{}]' '/numVersions/{printf("%c", $2+96)}' "$FILE")
ALL_VERS=$(eval echo {a..$NUM_VERSIONS})
for ver in $ALL_VERS; do
    for sol in "" _solutions; do
        f="${FILE%.tex}_$ver$sol.tex"
        solscript=""
        if [[ -z $sol ]]; then
            solscript='s/answerkey/%&/;s/% nosolutions/nosolutions/'
        fi
        sed -e "s/forVersion{a}/forVersion{$ver}/" \
            -e "$solscript" "$FILE" > tmp/"$f"
        yes X | latex -output-directory=tmp "$f"
        yes X | pdflatex -output-directory=tmp "$f"
        mv tmp/*.pdf .
    done
done
