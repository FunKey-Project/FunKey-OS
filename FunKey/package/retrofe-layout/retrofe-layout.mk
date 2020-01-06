################################################################################
#
# retrofe-layout
#
################################################################################
#https://bitbucket.org/keymu2/funkey_retrofe_layout_240x240/get/aaa4b639a5f1.zip
RETROFE_LAYOUT_VERSION = aaa4b639a5f1
RETROFE_LAYOUT_SOURCE = $(RETROFE_LAYOUT_VERSION).zip
RETROFE_LAYOUT_SITE = https://bitbucket.org/keymu2/funkey_retrofe_layout_240x240/get
RETROFE_LAYOUT_LICENSE = GPL-2.0+
RETROFE_LAYOUT_LICENSE_FILES = LICENSE.txt

define RETROFE_LAYOUT_INSTALL_TARGET_CMDS
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/games
	cp -r $(@D)/collections $(TARGET_DIR)/usr/games/
	cp -r $(@D)/launchers $(TARGET_DIR)/usr/games/
	cp -r $(@D)/layouts/Default_240x240 $(TARGET_DIR)/usr/games/layouts
	cp -r $(@D)/settings.conf $(TARGET_DIR)/usr/games/
	cp -r $(@D)/controls.conf $(TARGET_DIR)/usr/games/
endef

$(eval $(generic-package))
