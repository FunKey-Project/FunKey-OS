################################################################################
#
# mednafen
#
################################################################################

MEDNAFEN_VERSION = mednafen-git-FunKey-1.2.2
MEDNAFEN_SITE_METHOD = git
MEDNAFEN_SITE = https://github.com/FunKey-Project/mednafen-git.git
MEDNAFEN_LICENSE = GPL-2.0+
MEDNAFEN_LICENSE_FILES = COPYING

MEDNAFEN_DEPENDENCIES = sdl sdl_image sdl_mixer sdl_ttf zlib

MEDNAFEN_CFLAGS = $(TARGET_CFLAGS) $(subst $\",,$(BR2_TARGET_OPTIMIZATION)) -mfloat-abi=hard

#MEDNAFEN_AUTORECONF = YES

MEDNAFEN_CFLAGS += -ggdb -O3
MEDNAFEN_CFLAGS += -DFUNKEY_FAST_BLIT

#MEDNAFEN_LDFLAGS +=  -lSDL_ttf -lSDL_image

MEDNAFEN_CONF_OPTS += CXXFLAGS="$(MEDNAFEN_CFLAGS)"
#MEDNAFEN_CONF_OPTS += LDFLAGS="$(MEDNAFEN_LDFLAGS)"
MEDNAFEN_CONF_OPTS += --prefix=/usr/local --bindir=/usr/games --without-libsndfile
MEDNAFEN_CONF_OPTS += --disable-ss --disable-ssfplay --disable-fancy-scalers
#MEDNAFEN_CONF_OPTS += --disable-nes --disable-gba --disable-psx --disable-snes 

MEDNAFEN_CONF_ENV += SDL_CONFIG="$(STAGING_DIR)/usr/bin/sdl-config"

define MEDNAFEN_CREATE_OPK
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/local/share/OPKs/Emulators
	$(HOST_DIR)/usr/bin/mksquashfs $(MEDNAFEN_PKGDIR)/opk/gamegear $(TARGET_DIR)/usr/local/share/OPKs/Emulators/gamegear_mednafen_funkey-s.opk -all-root -noappend -no-exports -no-xattrs
	$(HOST_DIR)/usr/bin/mksquashfs $(MEDNAFEN_PKGDIR)/opk/lynx $(TARGET_DIR)/usr/local/share/OPKs/Emulators/lynx_mednafen_funkey-s.opk -all-root -noappend -no-exports -no-xattrs
	$(HOST_DIR)/usr/bin/mksquashfs $(MEDNAFEN_PKGDIR)/opk/ngp $(TARGET_DIR)/usr/local/share/OPKs/Emulators/ngp_mednafen_funkey-s.opk -all-root -noappend -no-exports -no-xattrs
	$(HOST_DIR)/usr/bin/mksquashfs $(MEDNAFEN_PKGDIR)/opk/pce $(TARGET_DIR)/usr/local/share/OPKs/Emulators/pce_mednafen_funkey-s.opk -all-root -noappend -no-exports -no-xattrs
	$(HOST_DIR)/usr/bin/mksquashfs $(MEDNAFEN_PKGDIR)/opk/wonderswan $(TARGET_DIR)/usr/local/share/OPKs/Emulators/wonderswan_mednafen_funkey-s.opk -all-root -noappend -no-exports -no-xattrs
endef
MEDNAFEN_POST_INSTALL_TARGET_HOOKS += MEDNAFEN_CREATE_OPK

$(eval $(autotools-package))
