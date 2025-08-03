################################################################################
#
# clock sdl app
#
################################################################################

CLOCK_VERSION = HEAD
CLOCK_SITE_METHOD = git
CLOCK_SITE = https://github.com/DrUm78/clock_sdl_app.git
CLOCK_LICENSE = GPL-2.1+
CLOCK_LICENSE_FILES = LICENSE

CLOCK_DEPENDENCIES = sdl

define CLOCK_BUILD_CMDS
	(cd $(@D); \
	sed -i -e 's|/opt/FunKey-sdk/usr/bin/arm-funkey-linux-musleabihf-gcc|../../host/usr/bin/arm-linux-gcc|g' Makefile.funkey; \
	make -f Makefile.funkey \
	)
endef

define CLOCK_INSTALL_TARGET_CMDS
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/bin
	$(INSTALL) -m 0755 $(@D)/clock $(TARGET_DIR)/usr/bin/
endef

define CLOCK_CREATE_OPK
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/local/share/OPKs/Settings
	$(HOST_DIR)/usr/bin/mksquashfs $(CLOCK_PKGDIR)/opk $(TARGET_DIR)/usr/local/share/OPKs/Settings/clock_funkey-s.opk -all-root -noappend -no-exports -no-xattrs
endef
CLOCK_POST_INSTALL_TARGET_HOOKS += CLOCK_CREATE_OPK

$(eval $(generic-package))
