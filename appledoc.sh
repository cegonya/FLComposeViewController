#!/bin/sh
set -e
rm -rf help
mkdir help
appledoc \
    --project-name FLComposeViewController \
    --project-company fernandotcl \
    --company-id com.fernandotcl \
    --no-repeat-first-par \
    --keep-undocumented-objects \
    --keep-undocumented-members \
    --output help \
    --no-create-docset \
    FLComposeViewController/*.h
rm -f docset-installed.txt
