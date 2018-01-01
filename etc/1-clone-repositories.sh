#!/bin/sh
##
##  GemstoneJS -- Gemstone JavaScript Technology Stack
##  Copyright (c) 2016-2018 Gemstone Project <http://gemstonejs.com>
##  Licensed under Apache License 2.0 <https://spdx.org/licenses/Apache-2.0>
##

basedir=`echo "$0" | sed -e 's;/[^/]*$;;'`
username=`whoami`
scheme="https"
if [ ".`egrep \"^$username .*DEVELOPER\" $basedir/0-manifest.txt`" != . ]; then
    scheme="ssh"
fi
for repo in `grep REPO $basedir/0-manifest.txt | sed -e 's; .*$;;'`; do
    url="$scheme://github.com/gemstonejs/$repo"
    if [ -d $repo ]; then
        echo "++ cloning: $repo <- $url [ALREADY EXISTS - SKIPPING]"
    else
        echo "++ cloning: $repo <- $url"
        git clone $url
    fi
done

