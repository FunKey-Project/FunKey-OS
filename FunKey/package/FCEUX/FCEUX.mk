################################################################################
#
# FCEUX
#
################################################################################

FCEUX_VERSION = fceux-FunKey-1.2.2
FCEUX_SITE_METHOD = git
FCEUX_SITE = https://github.com/FunKey-Project/fceux.git
FCEUX_LICENSE = GPL-2.0
FCEUX_LICENSE_FILES = COPYING

FCEUX_DEPENDENCIES = sdl sdl_image sdl_mixer sdl_ttf zlib

FCEUX_CFLAGS = $(TARGET_CFLAGS) $(subst $\",,$(BR2_TARGET_OPTIMIZATION)) -mfloat-abi=hard -ffast-math -funsafe-math-optimizations

FCEUX_CFLAGS += -ggdb -O3
FCEUX_CFLAGS += -Wno-write-strings -Wno-sign-compare
FCEUX_CFLAGS += -fomit-frame-pointer -fno-builtin -fno-common
FCEUX_CFLAGS += $(shell $(STAGING_DIR)/usr/bin/sdl-config --cflags)
FCEUX_CFLAGS +=  -DDINGUX \
	-DLSB_FIRST \
	-DPSS_STYLE=1 \
	-DHAVE_ASPRINTF \
	-DFRAMESKIP

FCEUX_LDFLAGS += $(FCEUX_CFLAGS) \
	-s -fprofile-generate -fprofile-dir=/home/retrofw/profile/fceux \
	-fno-strict-aliasing 

FCEUX_LIBS +=  $(shell $(STAGING_DIR)/usr/bin/sdl-config --libs)
FCEUX_LIBS += -lSDL -lSDL_image -lSDL_ttf -lpng  -lm -lz

define FCEUX_BUILD_CMDS
	(cd $(@D); \
	make \
	CFLAGS='$(FCEUX_CFLAGS)' \
	LDFLAGS='$(FCEUX_LDFLAGS)' \
	LIBS='$(FCEUX_LIBS)' \
	CROSS_COMPILE=$(TARGET_CROSS) \
	CHAINPREFIX='$(STAGING_DIR)/usr' \
	)
endef

define FCEUX_INSTALL_TARGET_CMDS
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/games
	$(INSTALL) -m 0755 $(@D)/fceux/fceux $(TARGET_DIR)/usr/games/fceux
endef

define FCEUX_CREATE_OPK
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/local/share/OPKs/Emulators
	$(HOST_DIR)/usr/bin/mksquashfs $(FCEUX_PKGDIR)/opk/nes $(TARGET_DIR)/usr/local/share/OPKs/Emulators/nes_fceux_funkey-s.opk -all-root -noappend -no-exports -no-xattrs
endef
FCEUX_POST_INSTALL_TARGET_HOOKS += FCEUX_CREATE_OPK

$(eval $(generic-package))
