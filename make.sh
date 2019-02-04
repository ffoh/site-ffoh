#!/bin/bash -e

#GLUON_TARGETS="ar71xx-generic ar71xx-nand ar71xx-tiny brcm2708-bcm2708 brcm2708-bcm2709 mpc85xx-generic x86-generic x86-kvm_guest x86-64 x86-xen_domu"
#GLUON_TARGETS="ar71xx-nand brcm2708-bcm2708 brcm2708-bcm2709 mpc85xx-generic x86-generic x86-kvm_guest x86-64 x86-xen_domu"
#GLUON_TARGETS=ar71xx-generic ar71xx-nand ar71xx-tiny brcm2708-bcm2708 brcm2708-bcm2709 mpc85xx-generic x86-generic x86-kvm_guest x86-64 x86-xen_domu; do
#GLUON_TARGETS="ar71xx-nand ar71xx-tiny brcm2708-bcm2708 brcm2708-bcm2709 mpc85xx-generic x86-generic x86-64 x86-xen_domu"
#GLUON_TARGETS="ar71xx-nand brcm2708-bcm2708 brcm2708-bcm2709 x86-64"
#GLUON_TARGETS="ar71xx-tiny ar71xx-generic mpc85xx-generic x86-generic"
#GLUON_TARGETS="mpc85xx-generic x86-generic"
#GLUON_TARGETS="ar71xx-generic"
GLUON_TARGETS=$(make | grep -- - |grep -iv make|cut -f3 -d' ')
#GLUON_TARGETS=$(ls targets | egrep -v "^generic" | grep -v "^targets" | grep -v mikrotik)
#GLUON_TARGETS="mpc85xx-generic ramips-mt7621 sunxi x86-generic x86-geode x86-64 ipq806x ramips-mt7620 ramips-mt7628 ramips-rt305x"
echo $GLUON_TARGETS

export GLUON_DATE=$(date '+%Y%m%d')

echo GLUON_DATE=$GLUON_DATE

#exit 0

for GLUON_TARGET in $GLUON_TARGETS
do
	if [ -z "$GLUON_TARGET" ]; then
		continue
	fi
	export GLUON_TARGET
	echo
	echo
	echo "***"
	echo "Preparing images for '$GLUON_TARGET'"
	echo "***"
	echo
	echo
	nice make GLUON_TARGET=$GLUON_TARGET V=s -j 8 BROKEN=1 clean
	# Gluon-Branch must be adjusted to bfo when builing for Bfo, otherwise the autoupdate will fail!
#	make GLUON_TARGET=$GLUON_TARGET V=s -j 6 BROKEN=1 GLUON_BRANCH=bfo
	nice make GLUON_TARGET=$GLUON_TARGET V=s -j 7 BROKEN=1 GLUON_DATE=$GLUON_DATE GLUON_BRANCH=experimental
	echo "***"
	echo "                      '$GLUON_TARGET' preparation ended"
	echo "***"
	echo
	#nice make manifest GLUON_BRANCH=bfo
	nice -n 20 make manifest GLUON_BRANCH=experimental
done
echo "[ok]"
