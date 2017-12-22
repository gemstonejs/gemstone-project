#!/bin/sh
##
##  GemstoneJS -- Gemstone JavaScript Technology Stack
##  Copyright (c) 2016-2017 Gemstone Project <http://gemstonejs.com>
##  Licensed under Apache License 2.0 <https://spdx.org/licenses/Apache-2.0>
##

basedir=`echo "$0" | sed -e 's;/[^/]*$;;'`
for pkg in `grep PKG $basedir/0-manifest.txt | sed -e 's; .*$;;'`; do
    echo "++ processing $pkg"
    (   cd $pkg
        if [ ! -f package.json ]; then
            echo "** ERROR: no package.json found"
            exit 1
        fi
        if [ -d node_modules ]; then
            rm -rf node_modules
        fi
        upd '!eslint-config-standard'
        npm install
		if [ -d node_modules ]; then
			(   cd node_modules || exit $?
				for mod in gemstone-*; do
					if [ ".$mod" = ".gemstone-*" ]; then
						continue
					fi
					echo "-- $pkg: symlinking $mod"
					rm -rf ./$mod
					ln -s ../../$mod $mod
				done
			)
		fi
    )
done

