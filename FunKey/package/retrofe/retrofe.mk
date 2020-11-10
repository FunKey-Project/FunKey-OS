################################################################################
#
# retrofe
#
################################################################################

RETROFE_VERSION = bdf516dce05003d8431554852df6311c76c47ccc
RETROFE_SITE_METHOD = git
#RETROFE_SITE = ssh://git@github.com/FunKey-Project/FunKey-Launcher-retrofe.git
RETROFE_SITE = ssh://git@fk/FunKey-Project/FunKey-Launcher-retrofe.git
RETROFE_DEPENDENCIES = gstreamer1 gst1-plugins-base sdl sdl_image sdl_mixer sdl_sound sdl_ttf libglib2 sqlite zlib
RETROFE_LICENSE = GPL-3.0
RETROFE_LICENSE_FILES = LICENSE.txt

RETROFE_SUBDIR = RetroFE/Source
RETROFE_SUPPORTS_IN_SOURCE_BUILD = NO
RETROFE_CONF_OPTS += -DVERSION_MAJOR=0 -DVERSION_MINOR=0 -DVERSION_BUILD=0

define RETROFE_INSTALL_TARGET_CMDS
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/games
	$(INSTALL) -m 0755 $(@D)/RetroFE/Build/retrofe $(TARGET_DIR)/usr/games/retrofe
endef

$(eval $(cmake-package))
