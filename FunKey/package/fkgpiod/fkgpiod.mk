################################################################################
#
# fkgpiod
#
################################################################################

FKGPIOD_VERSION = fkgpiod-FunKey-1.0.1
FKGPIOD_SITE_METHOD = git
FKGPIOD_SITE = https://github.com/FunKey-Project/fkgpiod.git
FKGPIOD_SITE_LICENSE = GPL-2.1+
FKGPIOD_SITE_LICENSE_FILES = COPYING

define FKGPIOD_BUILD_CMDS
	$(TARGET_MAKE_ENV) CROSS_COMPILE=$(TARGET_CROSS) \
		CC="$(TARGET_CC)" \
		$(MAKE) -C $(@D) \
		CFLAGS="$(TARGET_CFLAGS)" $(FKGPIOD_BUILD_TARGET)
endef

define FKGPIOD_INSTALL_TARGET_CMDS
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/local/sbin
	$(INSTALL) -m 0755 $(@D)/fkgpiod $(TARGET_DIR)/usr/local/sbin/fkgpiod
	$(INSTALL) -m 0755 $(@D)/termfix $(TARGET_DIR)/usr/local/sbin/termfix
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/etc
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/etc/init.d
	$(INSTALL) -m 0755 $(FKGPIOD_PKGDIR)etc/init.d/S11gpio $(TARGET_DIR)/etc/init.d/S11gpio
endef

$(eval $(generic-package))
