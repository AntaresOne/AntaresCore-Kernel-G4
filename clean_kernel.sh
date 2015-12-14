#!/bin/bash

export ARCH=arm64
export KERNEL_DIR=`readlink -f .`
export KERNEL_IMAGE_DIR=$KERNEL_DIR/arch/arm64/boot
export PACKAGE_DIR=$KERNEL_DIR/OUT
export TOOLCHAIN=`readlink -f ..`/aarch64-linux-android-4.9/bin/aarch64-linux-android-

echo "Cleaning out"
cp -pv .config .config.bkp
make ARCH=arm64 CROSS_COMPILE=$TOOLCHAIN mrproper
cp -pv .config.bkp .config
make clean && make mrproper
rm -f $KERNEL_IMAGE_DIR/Image
rm -f $KERNEL_IMAGE_DIR/Image.gz
rm -f $KERNEL_IMAGE_DIR/Image.gz-dtb
rm -rf $KERNEL_DIR/kernel/usr
rm -rf $PACKAGE_DIR/system
rm -f $PACKAGE_DIR/*.zip
rm -f $PACKAGE_DIR/boot.img

for i in `find . -type f \( -iname \*.rej \
				-o -iname \*.orig \
				-o -iname \*.bkp \
				-o -iname \*.ko \
				-o -iname \*.c.BACKUP.[0-9]*.c \
				-o -iname \*.c.BASE.[0-9]*.c \
				-o -iname \*.c.LOCAL.[0-9]*.c \
				-o -iname \*.c.REMOTE.[0-9]*.c \
				-o -iname \*.org \)`; do
	rm -vf $i
done

# Clear ccache
read -t 10 -p "Do you wish to clear ccache? (10 sec timeout [y/n])"
if [ "$REPLY" == "y" ]; then
	ccache -C
fi
