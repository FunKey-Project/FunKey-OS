# Makefile for FunKey-OS
#
# Copyright (C) 2020 by Michel Stempin <michel.stempin@funkey-project.com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
#

BRMAKE = buildroot/utils/brmake -C buildroot
BR = make -C buildroot

# Strip quotes and then whitespaces
qstrip = $(strip $(subst ",,$(1)))
#"))

# MESSAGE Macro -- display a message in bold type
MESSAGE = echo "$(shell date +%Y-%m-%dT%H:%M:%S) $(TERM_BOLD)\#\#\# $(call qstrip,$(1))$(TERM_RESET)"
TERM_BOLD := $(shell tput smso 2>/dev/null)
TERM_RESET := $(shell tput rmso 2>/dev/null)

.PHONY: fun source image update defconfig clean distclean

.IGNORE: _Makefile_

all: image update
	@:

_Makefile_:
	@:

%/Makefile:
	@:

buildroot: buildroot/.git
	@:

buildroot/.git:
	@$(call MESSAGE,"Getting buildroot")
	@git submodule init
	@git submodule update

fun: buildroot Recovery/output/.config FunKey/output/.config
	@$(call MESSAGE,"Making fun")
	@$(call MESSAGE,"Making fun in Recovery")
	@$(BRMAKE) BR2_EXTERNAL=../Recovery O=../Recovery/output
	@$(call MESSAGE,"Making fun in FunKey")
	@$(BRMAKE) BR2_EXTERNAL=../FunKey O=../FunKey/output

sdk: buildroot SDK/output/.config
	@$(call MESSAGE,"Making FunKey SDK")
	@$(BRMAKE) BR2_EXTERNAL=../SDK O=../SDK/output prepare-sdk
	@$(call MESSAGE,"Generating SDK tarball")
	@export LC_ALL=C; \
	SDK=FunKey-sdk-DrUm78; \
	grep -lr "$(shell pwd)/SDK/output/host" SDK/output/host | while read -r FILE ; do \
		if file -b --mime-type "$${FILE}" | grep -q '^text/'; then \
			sed -i "s|$(shell pwd)/SDK/output/host|/opt/$${SDK}|g" "$${FILE}"; \
		fi; \
	done; \
	mkdir -p images; \
	tar czf "images/$${SDK}.tar.gz" \
		--owner=0 --group=0 --numeric-owner \
		--transform="s#^$(patsubst /%,%,$(shell pwd))/SDK/output/host#$${SDK}#" \
		-C / "$(patsubst /%,%,$(shell pwd))/SDK/output/host"; \
	rm -f download/toolchain-external-custom/$${SDK}.tar.gz; \
	mkdir -p download/toolchain-external-custom; \
	ln -s ../../images/$${SDK}.tar.gz download/toolchain-external-custom/

FunKey/%: FunKey/output/.config
	@$(call MESSAGE,"Making $(notdir $@) in $(subst /,,$(dir $@))")
	@$(BR) BR2_EXTERNAL=../FunKey O=../FunKey/output $(notdir $@)

Recovery/%: Recovery/output/.config
	@$(call MESSAGE,"Making $(notdir $@) in $(subst /,,$(dir $@))")
	@$(BR) BR2_EXTERNAL=../Recovery O=../Recovery/output $(notdir $@)

SDK/%: SDK/output/.config
	@$(call MESSAGE,"Making $(notdir $@) in $(subst /,,$(dir $@))")
	@$(BR) BR2_EXTERNAL=../SDK O=../SDK/output $(notdir $@)

#%: FunKey/output/.config
#	@$(call MESSAGE,"Making $@ in FunKey")
#	@$(BR) BR2_EXTERNAL=../FunKey O=../FunKey/output $@

source:
	@$(call MESSAGE,"Getting sources")
	@$(BR) BR2_EXTERNAL=../SDK O=../SDK/output source
	@$(BR) BR2_EXTERNAL=../Recovery O=../Recovery/output source
	@$(BR) BR2_EXTERNAL=../FunKey O=../FunKey/output source

image: fun
	@$(call MESSAGE,"Creating disk image")
	@rm -rf root tmp
	@mkdir -p root tmp
	@./Recovery/output/host/bin/genimage --loglevel 0 --inputpath .
	@rm -rf root tmp
	@mv images/sdcard.img images/FunKey-sdcard-DrUm78.img

image-prod: fun
	@$(call MESSAGE,"Creating disk image")
	@rm -rf root tmp
	@mkdir -p root tmp
	@./Recovery/output/host/bin/genimage --loglevel 0 --config "genimage-prod.cfg" --inputpath .
	@rm -rf root tmp
	@mv images/sdcard-prod.img images/FunKey-sdcard-prod-DrUm78.img

update: fun
	@$(call MESSAGE,"Creating update file")
	@rm -rf tmp
	@mkdir -p tmp
	@cp FunKey/board/funkey/sw-description tmp/
	@cp FunKey/board/funkey/update_partition tmp/
	@cd FunKey/output/images && \
	rm -f rootfs.ext2.gz && \
	gzip -k rootfs.ext2 &&\
	mv rootfs.ext2.gz ../../../tmp/
	@cd tmp && \
	echo sw-description rootfs.ext2.gz update_partition | \
	tr " " "\n" | \
	cpio -o -H crc --quiet > ../images/FunKey-rootfs-DrUm78.fwu
	@rm -rf tmp

defconfig:
	@$(call MESSAGE,"Updating default configs")
	@$(call MESSAGE,"Updating default configs in SDK")
	@$(BR) BR2_EXTERNAL=../SDK O=../SDK/output savedefconfig
	@$(call MESSAGE,"Updating default configs in Recovery")
	@$(BR) BR2_EXTERNAL=../Recovery O=../Recovery/output savedefconfig linux-update-defconfig uboot-update-defconfig busybox-update-config
	@$(call MESSAGE,"Updating default configs in FunKey")
	@$(BR) BR2_EXTERNAL=../FunKey O=../FunKey/output savedefconfig linux-update-defconfig busybox-update-config

clean:
	@$(call MESSAGE,"Clean everything")
	@$(BR) BR2_EXTERNAL=../SDK O=../SDK/output distclean
	@$(BR) BR2_EXTERNAL=../Recovery O=../Recovery/output distclean
	@$(BR) BR2_EXTERNAL=../FunKey O=../FunKey/output distclean
	@rm -f br.log

distclean: clean
	@$(call MESSAGE,"Really clean everything")
	@rm -rf download images

FunKey/output/.config:
	@$(call MESSAGE,"Configure FunKey")
	@mkdir -p FunKey/board/funkey/patches
	@$(BR) BR2_EXTERNAL=../FunKey O=../FunKey/output funkey_defconfig

Recovery/output/.config:
	@$(call MESSAGE,"Configure Recovery")
	@mkdir -p Recovery/board/funkey/patches
	@$(BR) BR2_EXTERNAL=../Recovery O=../Recovery/output recovery_defconfig

SDK/output/.config:
	@$(call MESSAGE,"Configure SDK")
	@mkdir -p SDK/board/funkey/patches
	@$(BR) BR2_EXTERNAL=../SDK O=../SDK/output funkey_defconfig
