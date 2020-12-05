#############################################################
#
# libini
#
#############################################################
LIBINI_VERSION = c3413da
LIBINI_SITE_METHOD = git
LIBINI_SITE = https://github.com/FunKey-Project/libini.git
LIBINI_LICENSE = LGPL-2.1

LIBINI_INSTALL_STAGING = YES

$(eval $(cmake-package))
