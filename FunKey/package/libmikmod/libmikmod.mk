#############################################################
#
# libmikmod
#
#############################################################
LIBMIKMOD_VERSION:=3.3.11.1
LIBMIKMOD_SITE:=http://sourceforge.net/projects/mikmod/files/libmikmod/$(LIBMIKMOD_VERSION)

LIBMIKMOD_CONF_OPTS = --localstatedir=/var

LIBMIKMOD_LIBTOOL_PATCH = NO
LIBMIKMOD_INSTALL_STAGING = YES

LIBMIKMOD_CONFIG_SCRIPTS = libmikmod-config

define LIBMIKMOD_REMOVE_LIBMIKMOD_CONFIG
mv $(TARGET_DIR)/usr/bin/libmikmod-config $(HOST_DIR)/bin/
endef
LIBMIKMOD_POST_INSTALL_TARGET_HOOKS += LIBMIKMOD_REMOVE_LIBMIKMOD_CONFIG

$(eval $(autotools-package))
