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

.PHONY: fun source image clean distclean

.IGNORE: Makefile

all: fun image

fun: download Recovery/output/.config FunKey/output/.config
	@echo "*** Making fun"
	$(BRMAKE) BR2_EXTERNAL=../Recovery O=../Recovery/output
	$(BRMAKE) BR2_EXTERNAL=../FunKey O=../FunKey/output

FunKey/%: download FunKey/output/.config
	@echo "*** Making $(notdir $@) in $(subst /,,$(dir $@))"
	$(BR) BR2_EXTERNAL=../FunKey O=../FunKey/output $(notdir $@)

Recovery/%: download Recovery/output/.config
	@echo "*** Making $(notdir $@) in $(subst /,,$(dir $@))"
	$(BR) BR2_EXTERNAL=../Recovery O=../Recovery/output $(notdir $@)

%: download FunKey/output/.config
	@echo "*** Making $* in FunKey"
	$(BR) BR2_EXTERNAL=../FunKey O=../FunKey/output $*

source:
	@echo "*** Getting sources"
	$(BR) BR2_EXTERNAL=../Recovery O=../Recovery/output source
	$(BR) BR2_EXTERNAL=../FunKey O=../FunKey/output source

image:
	mkdir -p root tmp
	./Recovery/output/host/bin/genimage --inputpath .
	rm -rf root tmp

clean:
	@echo "*** Clean everything"
	$(BR) BR2_EXTERNAL=../Recovery O=../Recovery/output distclean
	$(BR) BR2_EXTERNAL=../FunKey O=../FunKey/output distclean

distclean: clean
	@echo "*** Really clean everything"
	rm -rf download images

download:
	@echo "*** Making download directory"
	mkdir -rf download

FunKey/output/.config:
	@echo "*** Configure FunKey"
	$(BR) BR2_EXTERNAL=../FunKey O=../FunKey/output funkey_defconfig

Recovery/output/.config:
	@echo "*** Configure Recovery"
	$(BR) BR2_EXTERNAL=../Recovery O=../Recovery/output recovery_defconfig
