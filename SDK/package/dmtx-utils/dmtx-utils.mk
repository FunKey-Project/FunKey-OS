################################################################################
#
# dmtx-utils
#
################################################################################

DMTX_UTILS_VERSION = 0.7.6
DMTX_UTILS_SITE = $(call github,dmtx,dmtx-utils,v$(DMTX_UTILS_VERSION))
DMTX_UTILS_DEPENDENCIES = libdmtx imagemagick
DMTX_UTILS_LICENSE = LGPL-2.1+
DMTX_UTILS_LICENSE_FILES = COPYING
# github tarball does not include configure
DMTX_UTILS_AUTORECONF = YES

define DMTX_UTILS_RUN_AUTOGEN
	cd $(@D) && PATH=$(BR_PATH) ./autogen.sh
endef
DMTX_UTILS_PRE_CONFIGURE_HOOKS += DMTX_UTILS_RUN_AUTOGEN

$(eval $(autotools-package))
