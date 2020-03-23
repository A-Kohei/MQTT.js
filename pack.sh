#!/bin/sh -x
PACKAGENAME="mqtt"
MQTT_INST_VER="2.12.0"

cd `dirname $0`

TARGET_DEV=""

VERSION=`head -n 1 debian/changelog | awk '{ print $2 }' | sed 's/[()]//g'`
VERSION_WON=`head -n 1 debian/changelog | awk '{ print $2 }' | sed 's/[()]//g' | sed 's/-.*$//g'`

cd ..

# -----------------
# clean
# -----------------
rm -Rf *_armhf.build
rm -Rf *_armhf.deb
rm -Rf *.orig.tar.gz
rm -Rf *_armhf.changes
rm -Rf *.dsc
rm -Rf *.tar.gz
rm -Rf *-${VERSION}* *_${VERSION}*

#cp -rf /usr/lib/node_modules/mqtt ${PACKAGENAME}-${VERSION}
#cp -rf ${PACKAGENAME}/* ${PACKAGENAME}-${VERSION}
cp -rf ${PACKAGENAME} ${PACKAGENAME}-${VERSION}

# -----------------
# clean2
# -----------------
cd ${PACKAGENAME}-${VERSION}
rm -rf .DS_Store .git* .idea autom4te.cache


# -----------------
# autoscan
# -----------------
./autoconf.sh

npm install -g mqtt@$MQTT_INST_VER
cp -rf /usr/lib/node_modules/mqtt/node_modules ./

tar zcfp ../${PACKAGENAME}-${VERSION_WON}.orig.tar.gz -C "../" ${PACKAGENAME}-${VERSION}

debuild -uc -us
