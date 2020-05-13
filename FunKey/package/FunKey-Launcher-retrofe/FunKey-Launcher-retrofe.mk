################################################################################
#
# FunKey-Launcher-retrofe
#
################################################################################

FUNKEY_LAUNCHER_RETROFE_VERSION = 0786a7af9aa24d702567b3f686ac9db84de287e1
FUNKEY_LAUNCHER_RETROFE_SITE_METHOD = git
#FUNKEY_LAUNCHER_RETROFE_SITE = ssh://git@github.com/FunKey-Project/FunKey-Launcher-retrofe.git
FUNKEY_LAUNCHER_RETROFE_SITE = ssh://git@fk/FunKey-Project/FunKey-Launcher-retrofe.git
FUNKEY_LAUNCHER_RETROFE_DEPENDENCIES = gstreamer1 gst1-plugins-base sdl sdl_image sdl_mixer sdl_sound sdl_ttf libglib2 sqlite zlib
FUNKEY_LAUNCHER_RETROFE_LICENSE = GPL-3.0
FUNKEY_LAUNCHER_RETROFE_LICENSE_FILES = LICENSE.txt

#FUNKEY_LAUNCHER_RETROFE_CONFIGURE_CMDS = ${BR2_CMAKE} RetroFE/Source -BRetroFE/Build -DVERSION_MAJOR=0 -DVERSION_MINOR=0 -DVERSION_BUILD=0

FUNKEY_LAUNCHER_RETROFE_SUBDIR = RetroFE/Source
FUNKEY_LAUNCHER_RETROFE_SUPPORTS_IN_SOURCE_BUILD = NO

FUNKEY_LAUNCHER_RETROFE_CONF_OPTS += -DVERSION_MAJOR=0 -DVERSION_MINOR=0 -DVERSION_BUILD=0

define FUNKEY_LAUNCHER_RETROFE_INSTALL_TARGET_CMDS
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/root/RetroFE
	$(INSTALL) -m 0755 $(@D)/RetroFE/Build/retrofe $(TARGET_DIR)/root/RetroFE/retrofe
endef

$(eval $(cmake-package))
