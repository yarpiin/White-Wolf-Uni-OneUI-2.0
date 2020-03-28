#!/bin/bash

# Bash Color
green='\033[01;32m'
red='\033[01;31m'
blink_red='\033[05;31m'
restore='\033[0m'

clear

# Resources
THREAD="-j$(grep -c ^processor /proc/cpuinfo)"
KERNEL="Image"
DTBIMAGE="dtb.img"

# Defconfigs
STARDEFCONFIG="exynos9810-starlte_defconfig"
STAR2DEFCONFIG="yarpiin_defconfig"
CROWNDEFCONFIG="exynos9810-crownlte_defconfig"

# Permissive Defconfigs
PERM_STARDEFCONFIG="perm_exynos9810-starlte_defconfig"
PERM_STAR2DEFCONFIG="perm_yarpiin_defconfig"
PERM_CROWNDEFCONFIG="perm_exynos9810-crownlte_defconfig"

# Build dirs
KERNEL_DIR="/home/yarpiin/Android/Kernel/UNI/White-Wolf-Uni-OneUI"
RESOURCE_DIR="$KERNEL_DIR/.."
KERNELFLASHER_DIR="/home/yarpiin/Android/Kernel/UNI/Build/KernelFlasher"
TOOLCHAIN_DIR="/home/yarpiin/Android/Toolchains"

# Kernel Details
BASE_YARPIIN_VER="WHITE.WOLF.ONEUI.UNI.Q"
VER=".00X"
PERM=".PERM"
YARPIIN_VER="$BASE_YARPIIN_VER$VER"
YARPIIN_PERM_VER="$BASE_YARPIIN_VER$VER$PERM"

# Vars
export LOCALVERSION=-`echo $YARPIIN_VER`
export CROSS_COMPILE="$TOOLCHAIN_DIR/aarch64-elf-gcc/bin/aarch64-elf-"
export ARCH=arm64
export SUBARCH=arm64
export KBUILD_BUILD_USER=yarpiin
export KBUILD_BUILD_HOST=kernel

# Paths
STARREPACK_DIR="/home/yarpiin/Android/Kernel/UNI/Build/Repack/G960/split_img"
STAR2REPACK_DIR="/home/yarpiin/Android/Kernel/UNI/Build/Repack/G965/split_img"
CROWNREPACK_DIR="/home/yarpiin/Android/Kernel/UNI/Build/Repack/N960/split_img"
STARIMG_DIR="/home/yarpiin/Android/Kernel/UNI/Build/Repack/G960"
STAR2IMG_DIR="/home/yarpiin/Android/Kernel/UNI/Build/Repack/G965"
CROWNIMG_DIR="/home/yarpiin/Android/Kernel/UNI/Build/Repack/N960"

# Permissive Paths
PERM_STARREPACK_DIR="/home/yarpiin/Android/Kernel/UNI/Build/Repack/G960/split_img"
PERM_STAR2REPACK_DIR="/home/yarpiin/Android/Kernel/UNI/Build/Repack/G965/split_img"
PERM_CROWNREPACK_DIR="/home/yarpiin/Android/Kernel/UNI/Build/Repack/N960/split_img"
PERM_STARIMG_DIR="/home/yarpiin/Android/Kernel/UNI/Build/Repack/G960"
PERM_STAR2IMG_DIR="/home/yarpiin/Android/Kernel/UNI/Build/Repack/G965"
PERM_CROWNIMG_DIR="/home/yarpiin/Android/Kernel/UNI/Build/Repack/N960"

# Image dirs
ZIP_MOVE="/home/yarpiin/Android/Kernel/UNI/Zip"
ZIMAGE_DIR="$KERNEL_DIR/arch/arm64/boot"

# Functions
function clean_all {
		if [ -f "$MODULES_DIR/*.ko" ]; then
			rm `echo $MODULES_DIR"/*.ko"`
		fi
		cd $STARIMG_DIR
		rm -rf zImage
		rm -rf img.dtb
		cd $STAR2IMG_DIR
		rm -rf zImage
		rm -rf img.dtb
		cd $KERNEL_DIR
		echo
		make clean && make mrproper
}

function make_star_kernel {
		echo
		make $STARDEFCONFIG
		make $THREAD
		cp -vr $ZIMAGE_DIR/$KERNEL $STARREPACK_DIR/G960.img-zImage
        cp -vr $ZIMAGE_DIR/$DTBIMAGE $STARREPACK_DIR/G960.img-dt
}

function repack_star {
		/bin/bash /home/yarpiin/Android/Kernel/UNI/Build/Repack/G960/repackimg.sh
		cd $STARIMG_DIR
		cp -vr image-new.img $KERNELFLASHER_DIR/G960.img
		cd $KERNEL_DIR
}

function make_star2_kernel {
		echo
		make $STAR2DEFCONFIG
		make $THREAD
		cp -vr $ZIMAGE_DIR/$KERNEL $STAR2REPACK_DIR/G965.img-zImage
        cp -vr $ZIMAGE_DIR/$DTBIMAGE $STAR2REPACK_DIR/G965.img-dt
}

function repack_star2 {
		/bin/bash /home/yarpiin/Android/Kernel/UNI/Build/Repack/G965/repackimg.sh
		cd $STAR2IMG_DIR
		cp -vr image-new.img $KERNELFLASHER_DIR/G965.img
		cd $KERNEL_DIR
}

function make_crown_kernel {
		echo
		make $CROWNDEFCONFIG
		make $THREAD
		cp -vr $ZIMAGE_DIR/$KERNEL $CROWNREPACK_DIR/N960.img-zImage
        cp -vr $ZIMAGE_DIR/$DTBIMAGE $CROWNREPACK_DIR/N960.img-dt
}

function repack_crown {
		/bin/bash /home/yarpiin/Android/Kernel/UNI/Build/Repack/N960/repackimg.sh
		cd $CROWNIMG_DIR
		cp -vr image-new.img $KERNELFLASHER_DIR/N960.img
		cd $KERNEL_DIR
}

function make_perm_star_kernel {
		echo
		make $PERM_STARDEFCONFIG
		make $THREAD
		cp -vr $ZIMAGE_DIR/$KERNEL $PERM_STARREPACK_DIR/G960.img-zImage
        cp -vr $ZIMAGE_DIR/$DTBIMAGE $PERM_STARREPACK_DIR/G960.img-dt
}

function repack_perm_star {
		/bin/bash /home/yarpiin/Android/Kernel/UNI/Build/Repack/G960/repackimg.sh
		cd $PERM_STARIMG_DIR
		cp -vr image-new.img $KERNELFLASHER_DIR/G960.img
		cd $KERNEL_DIR
}

function make_perm_star2_kernel {
		echo
		make $PERM_STAR2DEFCONFIG
		make $THREAD
		cp -vr $ZIMAGE_DIR/$KERNEL $PERM_STAR2REPACK_DIR/G965.img-zImage
        cp -vr $ZIMAGE_DIR/$DTBIMAGE $PERM_STAR2REPACK_DIR/G965.img-dt
}

function repack_perm_star2 {
		/bin/bash /home/yarpiin/Android/Kernel/UNI/Build/Repack/G965/repackimg.sh
		cd $PERM_STAR2IMG_DIR
		cp -vr image-new.img $KERNELFLASHER_DIR/G965.img
		cd $KERNEL_DIR
}

function make_perm_crown_kernel {
		echo
		make $PERM_CROWNDEFCONFIG
		make $THREAD
		cp -vr $ZIMAGE_DIR/$KERNEL $PERM_CROWNREPACK_DIR/N960.img-zImage
        cp -vr $ZIMAGE_DIR/$DTBIMAGE $PERM_CROWNREPACK_DIR/N960.img-dt
}

function repack_perm_crown {
		/bin/bash /home/yarpiin/Android/Kernel/UNI/Build/Repack/N960/repackimg.sh
		cd $PERM_CROWNIMG_DIR
		cp -vr image-new.img $KERNELFLASHER_DIR/N960.img
		cd $KERNEL_DIR
}

function make_zip {
		cd $KERNELFLASHER_DIR
		zip -r9 `echo $YARPIIN_VER`.zip *
		mv  `echo $YARPIIN_VER`.zip $ZIP_MOVE
		cd $KERNEL_DIR
}

function make_perm_zip {
		cd $KERNELFLASHER_DIR
		zip -r9 `echo $YARPIIN_PERM_VER`.zip *
		mv  `echo $YARPIIN_PERM_VER`.zip $ZIP_MOVE
		cd $KERNEL_DIR
}
DATE_START=$(date +"%s")

echo -e "${green}"
echo "YARPIIN Kernel Creation Script:"
echo

echo "---------------"
echo "Kernel Version:"
echo "---------------"

echo -e "${red}"; echo -e "${blink_red}"; echo "$YARPIIN_VER"; echo -e "${restore}";

echo -e "${green}"
echo "-----------------"
echo "Making YARPIIN Kernel:"
echo "-----------------"
echo -e "${restore}"

while read -p "Do you want to clean stuffs (y/n)? " cchoice
do
case "$cchoice" in
	y|Y )
		clean_all
		echo
		echo "All Cleaned now."
		break
		;;
	n|N )
		break
		;;
	* )
		echo
		echo "Invalid try again!"
		echo
		;;
esac
done

echo

while read -p "Do you want to build G965 kernel (y/n)? " dchoice
do
case "$dchoice" in
	y|Y)
		make_star2_kernel
        repack_star2
		break
		;;
	n|N )
		break
		;;
	* )
		echo
		echo "Invalid try again!"
		echo
		;;
esac
done

echo

while read -p "Do you want to clean stuffs (y/n)? " cchoice
do
case "$cchoice" in
	y|Y )
		clean_all
		echo
		echo "All Cleaned now."
		break
		;;
	n|N )
		break
		;;
	* )
		echo
		echo "Invalid try again!"
		echo
		;;
esac
done

echo

while read -p "Do you want to build G960 kernel (y/n)? " dchoice
do
case "$dchoice" in
	y|Y)
		make_star_kernel
        repack_star
		break
		;;
	n|N )
		break
		;;
	* )
		echo
		echo "Invalid try again!"
		echo
		;;
esac
done

echo

while read -p "Do you want to clean stuffs (y/n)? " cchoice
do
case "$cchoice" in
	y|Y )
		clean_all
		echo
		echo "All Cleaned now."
		break
		;;
	n|N )
		break
		;;
	* )
		echo
		echo "Invalid try again!"
		echo
		;;
esac
done

echo

while read -p "Do you want to build N960 kernel (y/n)? " dchoice
do
case "$dchoice" in
	y|Y)
		make_crown_kernel
        repack_crown
		break
		;;
	n|N )
		break
		;;
	* )
		echo
		echo "Invalid try again!"
		echo
		;;
esac
done

echo

while read -p "Do you want to zip kernel (y/n)? " dchoice
do
case "$dchoice" in
	y|Y)
		make_zip
		break
		;;
	n|N )
		break
		;;
	* )
		echo
		echo "Invalid try again!"
		echo
		;;
esac
done

echo -e "${green}"
echo "-------------------"
echo "Build Completed in:"
echo "-------------------"
echo -e "${restore}"

DATE_END=$(date +"%s")
DIFF=$(($DATE_END - $DATE_START))
echo "Time: $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."
echo

