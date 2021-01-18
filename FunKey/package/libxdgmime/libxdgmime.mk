#############################################################
#
# libxdgmime
#
#############################################################
LIBXDGMIME_VERSION = libxdgmime-FunKey-1.0.0
LIBXDGMIME_SITE_METHOD = git
LIBXDGMIME_SITE = https://github.com/FunKey-Project/libxdgmime.git
LIBXDGMIME_DEPENDENCIES = shared-mime-info
LIBXDGMIME_LICENCE = LGPL-2.1+ or AFL-2.1

LIBXDGMIME_INSTALL_STAGING = YES

LIBXDGMIME_MAKE_ENV = CFLAGS="$(TARGET_CFLAGS)" LDFLAGS="$(TARGET_LDFLAGS)" \
				  CROSS_COMPILE="$(TARGET_CROSS)" PREFIX=/usr \
				  PLATFORM="$(BR2_VENDOR)"

define LIBXDGMIME_BUILD_CMDS
	$(LIBXDGMIME_MAKE_ENV) $(MAKE) -C $(@D)
endef

define LIBXDGMIME_INSTALL_STAGING_CMDS
	$(LIBXDGMIME_MAKE_ENV) DESTDIR="$(STAGING_DIR)" $(MAKE) -C $(@D) install
endef

define LIBXDGMIME_INSTALL_TARGET_CMDS
	$(LIBXDGMIME_MAKE_ENV) DESTDIR="$(TARGET_DIR)" $(MAKE) -C $(@D) install-lib
endef

$(eval $(generic-package))
