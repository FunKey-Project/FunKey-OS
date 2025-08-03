################################################################################
#
# picoarch
#
################################################################################

PICOARCH_VERSION = HEAD
PICOARCH_SITE_METHOD = git
PICOARCH_SITE = https://git.crowdedwood.com/picoarch
PICOARCH_LICENSE = GPL-2+, LGPL-2.1+, MAME
PICOARCH_LICENSE_FILES = LICENSE

PICOARCH_DEPENDENCIES = sdl sdl_image sdl_ttf

PICOARCH_SDL_CFLAGS += $(shell $(STAGING_DIR)/usr/bin/sdl-config --cflags)
PICOARCH_SDL_LIBS   += $(shell $(STAGING_DIR)/usr/bin/sdl-config --libs)

PICOARCH_CFLAGS += $(PICOARCH_SDL_CFLAGS)
PICOARCH_CFLAGS += -DFUNKEY_S -Ofast -DNDEBUG  -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64
PICOARCH_CFLAGS += -Wall -fdata-sections -ffunction-sections -flto
PICOARCH_CFLAGS += -I./ -I./libretro-common/include/

PICOARCH_LIBS += $(PICOARCH_SDL_LIBS)
PICOARCH_LIBS += -lc -ldl -lgcc -lm -lSDL -lasound -lpng -lz -Wl,--gc-sections -flto -lSDL_image -lSDL_ttf

define PICOARCH_BUILD_CMDS
	(cd $(@D); \
	make picoarch platform=funkey-s \
	CROSS_COMPILE=$(TARGET_CROSS) \
	CFLAGS='$(PICOARCH_CFLAGS)' \
	LDFLAGS='$(PICOARCH_LIBS)' \
	SDL_INCLUDES='$(PICOARCH_SDL_CFLAGS)' \
	SDL_LIBS='$(PICOARCH_SDL_LIBS)' \
	)
endef

PICOARCH_GIT_SUBMODULES = YES

define PICOARCH_INSTALL_TARGET_CMDS
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/games
	$(INSTALL) -m 0755 $(@D)/picoarch $(TARGET_DIR)/usr/games/
endef

define PICOARCH_CREATE_OPK
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/local/share/OPKs/Libretro
	$(HOST_DIR)/usr/bin/mksquashfs $(PICOARCH_PKGDIR)/opk/picoarch $(TARGET_DIR)/usr/local/share/OPKs/Libretro/picoarch_funkey-s.opk -all-root -noappend -no-exports -no-xattrs
	$(HOST_DIR)/usr/bin/mksquashfs $(PICOARCH_PKGDIR)/opk/gb_gbc $(TARGET_DIR)/usr/local/share/OPKs/Libretro/gb_gbc_picoarch_funkey-s.opk -all-root -noappend -no-exports -no-xattrs
	$(HOST_DIR)/usr/bin/mksquashfs $(PICOARCH_PKGDIR)/opk/gba $(TARGET_DIR)/usr/local/share/OPKs/Libretro/gba_picoarch_funkey-s.opk -all-root -noappend -no-exports -no-xattrs
	$(HOST_DIR)/usr/bin/mksquashfs $(PICOARCH_PKGDIR)/opk/lynx $(TARGET_DIR)/usr/local/share/OPKs/Libretro/lynx_picoarch_funkey-s.opk -all-root -noappend -no-exports -no-xattrs
	$(HOST_DIR)/usr/bin/mksquashfs $(PICOARCH_PKGDIR)/opk/megadrive $(TARGET_DIR)/usr/local/share/OPKs/Libretro/megadrive_picoarch_funkey-s.opk -all-root -noappend -no-exports -no-xattrs
	$(HOST_DIR)/usr/bin/mksquashfs $(PICOARCH_PKGDIR)/opk/nes $(TARGET_DIR)/usr/local/share/OPKs/Libretro/nes_picoarch_funkey-s.opk -all-root -noappend -no-exports -no-xattrs
	$(HOST_DIR)/usr/bin/mksquashfs $(PICOARCH_PKGDIR)/opk/ngp $(TARGET_DIR)/usr/local/share/OPKs/Libretro/ngp_picoarch_funkey-s.opk -all-root -noappend -no-exports -no-xattrs
	$(HOST_DIR)/usr/bin/mksquashfs $(PICOARCH_PKGDIR)/opk/pce $(TARGET_DIR)/usr/local/share/OPKs/Libretro/pce_picoarch_funkey-s.opk -all-root -noappend -no-exports -no-xattrs
	$(HOST_DIR)/usr/bin/mksquashfs $(PICOARCH_PKGDIR)/opk/ps1 $(TARGET_DIR)/usr/local/share/OPKs/Libretro/ps1_picoarch_funkey-s.opk -all-root -noappend -no-exports -no-xattrs
	$(HOST_DIR)/usr/bin/mksquashfs $(PICOARCH_PKGDIR)/opk/snes $(TARGET_DIR)/usr/local/share/OPKs/Libretro/snes_picoarch_funkey-s.opk -all-root -noappend -no-exports -no-xattrs
	$(HOST_DIR)/usr/bin/mksquashfs $(PICOARCH_PKGDIR)/opk/wonderswan $(TARGET_DIR)/usr/local/share/OPKs/Libretro/wonderswan_picoarch_funkey-s.opk -all-root -noappend -no-exports -no-xattrs
endef
PICOARCH_POST_INSTALL_TARGET_HOOKS += PICOARCH_CREATE_OPK

$(eval $(generic-package))
