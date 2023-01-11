#!/bin/sh

DEBVER=`grep '^Version' fmtlib-erpg_5.3.0-1.dsc | tr -cd '[0-9\.\-]'`
DEBTAR="fmtlib-erpg_${DEBVER}.debian.tar.xz"

echo "Creating ${DEBTAR}:"

tar -cvJf "${DEBTAR}" debian

echo "Updating checksums..."

ORIGVER=`echo ${DEBVER} | cut -d- -f1`
ORIGTAR="fmtlib-erpg_${ORIGVER}.orig.tar.gz"
ORIGSIZE=`stat -c %s ${ORIGTAR}`

DEBSIZE=`stat -c %s ${DEBTAR}`

echo " `sha256sum ${ORIGTAR} | cut -d' ' -f1` ${ORIGSIZE} fmtlib-erpg_${ORIGVER}.orig.tar.gz" > checksums.txt
echo " `sha256sum ${DEBTAR} | cut -d' ' -f1` ${DEBSIZE} ${DEBTAR}" >> checksums.txt
echo "Checksums-Sha1:" >> checksums.txt
echo " `sha1sum ${ORIGTAR} | cut -d' ' -f1` ${ORIGSIZE} fmtlib-erpg_${ORIGVER}.orig.tar.gz" >> checksums.txt
echo " `sha1sum ${DEBTAR} | cut -d' ' -f1` ${DEBSIZE} ${DEBTAR}" >> checksums.txt
echo "Files:" >> checksums.txt
echo " `md5sum ${ORIGTAR} | cut -d' ' -f1` ${ORIGSIZE} fmtlib-erpg_${ORIGVER}.orig.tar.gz" >> checksums.txt
echo " `md5sum ${DEBTAR} | cut -d' ' -f1` ${DEBSIZE} ${DEBTAR}" >> checksums.txt

lead='^Checksums-Sha256:$'
sed -i "/$lead/,$ { /$lead/{p; r checksums.txt
        }; d }" fmtlib-erpg_5.3.0-1.dsc

rm checksums.txt
