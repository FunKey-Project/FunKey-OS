################################################################################
#
# gpsp
#
################################################################################

GPSP_VERSION = b573bc6
GPSP_SITE_METHOD = git
GPSP_SITE = https://github.com/FunKey-Project/gpsp.git
GPSP_LICENSE = GPL-2.0
GPSP_LICENSE_FILES = COPYING.DOC

GPSP_DEPENDENCIES = sdl sdl_image sdl_mixer sdl_ttf zlib

GPSP_CFLAGS = $(TARGET_CFLAGS) $(subst $\",,$(BR2_TARGET_OPTIMIZATION)) -mfloat-abi=hard -ffast-math -funsafe-math-optimizations

GPSP_SDL_CFLAGS += $(shell $(STAGING_DIR)/usr/bin/sdl-config --cflags)
GPSP_SDL_LIBS += $(shell $(STAGING_DIR)/usr/bin/sdl-config --libs)

GPSP_CFLAGS += -ggdb -O3
GPSP_CFLAGS += -DARM_ARCH -DCHIP_BUILD
GPSP_CFLAGS += $(GPSP_SDL_CFLAGS)

GPSP_LIBS += $(GPSP_SDL_LIBS)
GPSP_LIBS += -lSDL_ttf -lSDL_image -ldl -lpthread -lz

define GPSP_BUILD_CMDS
	(cd $(@D)/chip; \
	sed -i -e 's/-gcc/gcc/g' Makefile; \
	make \
	CROSS_COMPILE=$(TARGET_CROSS) \
	CFLAGS='$(GPSP_CFLAGS)' \
	LIBS='$(GPSP_LIBS)' \
	)
endef

define GPSP_INSTALL_TARGET_CMDS
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/games
	$(INSTALL) -m 0755 $(@D)/chip/gpsp $(TARGET_DIR)/usr/games/gpsp
	$(INSTALL) -m 0644 $(@D)/game_config.txt $(TARGET_DIR)/usr/games/game_config.txt
endef

define GPSP_CREATE_OPK
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/local/share/OPKs/Emulators
	$(HOST_DIR)/usr/bin/mksquashfs $(GPSP_PKGDIR)/opk/gba $(TARGET_DIR)/usr/local/share/OPKs/Emulators/gba_gpsp_funkey-s.opk -all-root -noappend -no-exports -no-xattrs
endef
GPSP_POST_INSTALL_TARGET_HOOKS += GPSP_CREATE_OPK

$(eval $(generic-package))
