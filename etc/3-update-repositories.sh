#!/bin/sh
##
##  GemstoneJS -- Gemstone JavaScript Technology Stack
##  Copyright (c) 2016-2017 Gemstone Project <http://gemstonejs.com>
##  Licensed under Apache License 2.0 <https://spdx.org/licenses/Apache-2.0>
##

basedir=`echo "$0" | sed -e 's;/[^/]*$;;'`
for repo in `grep REPO $basedir/0-manifest.txt | sed -e 's; .*$;;'`; do
    echo "++ updating: $repo"
    if [ ! -d $repo ]; then
        echo "** ERROR: $repo not existing"
        exit 1
    fi
    (   cd $repo || exit $?
        git pull
    )
done

