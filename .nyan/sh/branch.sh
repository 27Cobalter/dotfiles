#!/bin/sh
cd $@ && \
git branch 2>/dev/null | grep \* | sed -e "s/\* /`echo -ne '\u2b60'`/g"
