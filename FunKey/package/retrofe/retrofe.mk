################################################################################
#
# retrofe
#
################################################################################
#https://bitbucket.org/keymu2/funkey_retrofe/get/0961a03bf242.zip
RETROFE_VERSION = 0961a03bf242
RETROFE_SOURCE = $(RETROFE_VERSION).zip
RETROFE_SITE = https://bitbucket.org/keymu2/funkey_retrofe/get
RETROFE_LICENSE = GPL-2.0+
RETROFE_LICENSE_FILES = LICENSE.txt
RETROFE_SUBDIR = RetroFE/Source

RETROFE_DEPENDENCIES = libglib2 gstreamer1 gst1-plugins-base sdl sdl_image sdl_mixer sdl_ttf sdl_gfx zlib

define RETROFE_INSTALL_TARGET_CMDS
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/games
	$(INSTALL) -m 0755 $(@D)/RetroFE/Build/retrofe $(TARGET_DIR)/usr/games/retrofe
endef

$(eval $(cmake-package))
