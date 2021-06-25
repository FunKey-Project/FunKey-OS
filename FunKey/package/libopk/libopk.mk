#############################################################
#
# libopk
#
#############################################################

LIBOPK_VERSION = libopk-FunKey-1.0.3
LIBOPK_SITE_METHOD = git
LIBOPK_SITE = https://github.com/FunKey-Project/libopk.git

LIBOPK_DEPENDENCIES = libini zlib

LIBOPK_INSTALL_STAGING = YES

$(eval $(cmake-package))
