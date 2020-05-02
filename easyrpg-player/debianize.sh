#!/bin/bash

DEBVER=$(grep '^Version' easyrpg-player.dsc | tr -cd '[0-9\.\-]')
DEBTAR="easyrpg-player_${DEBVER}.debian.tar.xz"
ORIGVER=$(echo ${DEBVER} | cut -d- -f1)
ORIGTAR="easyrpg-player_${ORIGVER}.orig.tar.xz"

function add_checksums() {
	local DSCFILE=$1
	local ORIGSIZE=$(stat -c %s ${ORIGTAR})
	local DEBSIZE=$(stat -c %s ${DEBTAR})

	local origsha256=$(sha256sum ${ORIGTAR} | cut -d' ' -f1)
	local debsha256=$(sha256sum ${DEBTAR} | cut -d' ' -f1)
	local origsha1=$(sha1sum ${ORIGTAR} | cut -d' ' -f1)
	local debsha1=$(sha1sum ${DEBTAR} | cut -d' ' -f1)
	local origmd5=$(md5sum ${ORIGTAR} | cut -d' ' -f1)
	local debmd5=$(md5sum ${DEBTAR} | cut -d' ' -f1)

	echo " ${origsha256} ${ORIGSIZE} ${ORIGTAR}" > checksums.txt
	echo " ${debsha256} ${DEBSIZE} ${DEBTAR}" >> checksums.txt
	echo "Checksums-Sha1:" >> checksums.txt
	echo " ${origsha1} ${ORIGSIZE} ${ORIGTAR}" >> checksums.txt
	echo " ${debsha1} ${DEBSIZE} ${DEBTAR}" >> checksums.txt
	echo "Files:" >> checksums.txt
	echo " ${origmd5} ${ORIGSIZE} ${ORIGTAR}" >> checksums.txt
	echo " ${debmd5} ${DEBSIZE} ${DEBTAR}" >> checksums.txt

	local lead='^Checksums-Sha256:$'
	sed -i "/$lead/,$ { /$lead/{p; r checksums.txt
        }; d }" ${DSCFILE}

	rm checksums.txt
}

echo "Copying source archive:"
cp "easyrpg-player-${ORIGVER}.tar.xz" $ORIGTAR

echo "Creating ${DEBTAR}:"
tar -cJf "${DEBTAR}" --exclude='*.ex' --exclude='*.bak' debian

echo "Updating checksums..."
add_checksums easyrpg-player.dsc

OLDDEBVER=${DEBVER}
DEBVER="${OLDDEBVER}oldstable"
DEBTAR="easyrpg-player_${DEBVER}.debian.tar.xz"
COMPATDISTRO="Debian_9.0"

echo "Generating compat package for xUbuntu_18.04/18.10 Bionic/Cosmic and Debian 9"

# disable mp3 support
sed -e 's/, libmpg123-dev//' \
  -e "s/${OLDDEBVER}/${DEBVER}/" \
  easyrpg-player.dsc > "easyrpg-player-${COMPATDISTRO}.dsc"
sed -i'.bak' 's/, libmpg123-dev//' debian/control

echo "Creating ${DEBTAR}:"
tar -cJf "${DEBTAR}" --exclude='*.ex' --exclude='*.bak' debian

echo "Updating checksums..."
add_checksums "easyrpg-player-${COMPATDISTRO}.dsc"

cp "easyrpg-player-${COMPATDISTRO}.dsc" "easyrpg-player-xUbuntu_18.04.dsc"
cp "easyrpg-player-${COMPATDISTRO}.dsc" "easyrpg-player-xUbuntu_18.10.dsc"

DEBVER="${OLDDEBVER}xenial"
DEBTAR="easyrpg-player_${DEBVER}.debian.tar.xz"
COMPATDISTRO="xUbuntu_16.04"

echo "Generating compat package for ${COMPATDISTRO} Xenial"

# downgrade debhelper (no parallel builds)
sed -i'.bak' 's/10/9/' debian/compat
sed -i 's/debhelper (>= 10)/debhelper (>= 9)/' debian/control
sed -e 's/, libmpg123-dev//' \
  -e 's/debhelper (>= 10)/debhelper (>= 9)/' \
  -e "s/${OLDDEBVER}/${DEBVER}/" \
  easyrpg-player.dsc > "easyrpg-player-${COMPATDISTRO}.dsc"

echo "Creating ${DEBTAR}:"
tar -cJf "${DEBTAR}" --exclude='*.ex' --exclude='*.bak' debian

echo "Updating checksums..."
add_checksums "easyrpg-player-${COMPATDISTRO}.dsc"

mv debian/compat.bak debian/compat
mv debian/control.bak debian/control
