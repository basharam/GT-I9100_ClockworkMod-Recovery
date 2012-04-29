#!/bin/bash -x

OUTDIR=/android/clockworkmod/GT-I9100/out
INITRAMFSDIR=/android/clockworkmod/GT-I9100/ramdisk
TOOLCHAIN=/android/ics/prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin/arm-eabi-

export USE_SEC_FIPS_MODE=true

cd kernel
make u1_defconfig
make -j8 ARCH=arm CROSS_COMPILE=$TOOLCHAIN CONFIG_INITRAMFS_SOURCE="$INITRAMFSDIR" modules

cp drivers/net/wireless/bcmdhd/dhd.ko ${INITRAMFSDIR}/lib/modules
cp drivers/samsung/fm_si4709/Si4709_driver.ko ${INITRAMFSDIR}/lib/modules
cp drivers/scsi/scsi_wait_scan.ko ${INITRAMFSDIR}/lib/modules
cp drivers/samsung/j4fs/j4fs.ko ${INITRAMFSDIR}/lib/modules

make -j8 ARCH=arm CROSS_COMPILE=$TOOLCHAIN CONFIG_INITRAMFS_SOURCE="$INITRAMFSDIR" zImage

cp arch/arm/boot/zImage ${OUTDIR}


