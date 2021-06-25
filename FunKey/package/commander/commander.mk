#############################################################
#
# commander
#
#############################################################
COMMANDER_VERSION = commander-FunKey-1.1.1
COMMANDER_SITE_METHOD = git
COMMANDER_SITE = https://github.com/FunKey-Project/commander.git
COMMANDER_LICENSE = GPL-2.0

COMMANDER_DEPENDENCIES = sdl sdl_ttf sdl_gfx

COMMANDER_CONF_OPTS = -DCMAKE_BUILD_TYPE=Release -DTARGET_PLATFORM="funkey-s" -DRES_DIR=""
#COMMANDER_CONF_OPTS += -DWITH_SYSTEM_SDL_GFX=ON -DWITH_SYSTEM_SDL_TTF=ON

define COMMANDER_INSTALL_CMDS
endef

define COMMANDER_CREATE_OPK
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/local/share/OPKs/Applications
	cd $(@D); \
	$(HOST_DIR)/usr/bin/mksquashfs \
		opkg/default.funkey-s.desktop \
		opkg/readme.funkey-s.txt \
		opkg/commander.png \
		res/file-image.png \
		res/file-ipk.png \
		res/file-is-symlink.png \
		res/file-opk.png \
		res/file-text.png \
		res/folder.png res/up.png \
		res/DroidSansFallback.ttf \
		res/Fiery_Turk.ttf \
		res/FreeSans.ttf \
		$(TARGET_DIR)/usr/bin/commander \
		$(TARGET_DIR)/usr/local/share/OPKs/Applications/commander-funkey-s.opk \
		-all-root -noappend -no-exports -no-xattrs -noappend; \
	rm -rf $(TARGET_DIR)/usr/bin/commander
endef
COMMANDER_POST_INSTALL_TARGET_HOOKS += COMMANDER_CREATE_OPK

$(eval $(cmake-package))
