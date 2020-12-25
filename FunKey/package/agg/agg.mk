###############################################################################
#
# agg
#
###############################################################################

AGG_VERSION = 2.5
AGG_SOURCE = agg-$(AGG_VERSION).tar.gz
AGG_SITE = https://ftp.osuosl.org/pub/blfs/8.0/a
AGG_LICENSE = GPLv3+
AGG_LICENSE_FILES = COPYING
AGG_INSTALL_STAGING = YES
AGG_AUTORECONF = YES

AGG_DEPENDENCIES = host-pkgconf sdl

AGG_CONF_OPTS = \
        --with-sdl-prefix=$(STAGING_DIR)/usr \
        --disable-sdltest

AGG_CONF_OPTS += \
	--with-x=NO \
	--disable-examples --disable-gpc

ifeq ($(BR2_PACKAGE_FREETYPE),y)
AGG_DEPENDENCIES += freetype
AGG_CONF_OPTS += --enable-freetype
else
AGG_CONF_OPTS += --disable-freetype
endif

$(eval $(autotools-package))
