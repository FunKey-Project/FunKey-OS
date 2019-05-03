#!/bin/sh

BR="make -C buildroot BR2_EXTERNAL=../FunKey O=../FunKey/output"

case "$1" in
    start)
	$BR distclean funkey_defconfig
    ;;
    update)
	$BR savedefconfig linux-update-defconfig uboot-update-defconfig
    ;;
    *)
	$BR $*
    ;;
esac
