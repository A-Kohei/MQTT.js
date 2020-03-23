#!/bin/sh

cd `dirname $0`

touch NEWS README AUTHORS ChangeLog

autoscan
mv configure.scan configure.ac
rm -rf autoscan.log

LINE=`cat -n configure.ac | grep "AC_INIT" | awk '{ printf("%s", $1) }'`
head -n ${LINE} configure.ac > tmp.txt
echo "AM_INIT_AUTOMAKE([subdir-objects])" >> tmp.txt
tail -n +`expr $LINE + 1` configure.ac >> tmp.txt
mv -f tmp.txt configure.ac

autoreconf --install
