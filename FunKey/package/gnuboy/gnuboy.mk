################################################################################
#
# gnuboy
#
################################################################################

GNUBOY_VERSION = gnuboy-FunKey-1.00
GNUBOY_SITE_METHOD = git
GNUBOY_SITE = https://github.com/FunKey-Project/gnuboy.git
GNUBOY_LICENSE = GPL-2.0
GNUBOY_LICENSE_FILES = COPYING

GNUBOY_DEPENDENCIES = sdl sdl_image sdl_mixer sdl_ttf zlib

GNUBOY_CFLAGS = $(TARGET_CFLAGS)

ifeq ($(BR2_ARM_CPU_ARMV7A),y)
GNUBOY_CFLAGS += -march=armv7-a
endif

ifeq ($(BR2_GCC_TARGET_CPU),"cortex-a7")
GNUBOY_CFLAGS += -mtune=cortex-a7
endif

ifeq ($(BR2_GCC_TARGET_FLOAT_ABI),"hard")
GNUBOY_CFLAGS += -mfloat-abi=hard -ffast-math -funsafe-math-optimizations
else ifeq ($(BR2_GCC_TARGET_FLOAT_ABI),"soft")
GNUBOY_CFLAGS += -mfloat-abi=soft -ffast-math -funsafe-math-optimizations
endif

ifeq ($(BR2_ARM_CPU_HAS_NEON),y)
GNUBOY_CFLAGS += -D__ARM_NEON__ -mfpu=neon -mvectorize-with-neon-quad
endif

GNUBOY_CFLAGS += -ggdb -O3

GNUBOY_CONF_OPTS += CFLAGS="$(GNUBOY_CFLAGS)"
GNUBOY_CONF_OPTS += --prefix=$(TARGET_DIR)/usr/local --bindir=$(TARGET_DIR)/usr/games
GNUBOY_CONF_OPTS += --without-fb \
		    --without-svgalib \
		    --without-x \
		    --with-sdl

GNUBOY_CONF_ENV += SDL_CONFIG="$(STAGING_DIR)/usr/bin/sdl-config"

define GNUBOY_CREATE_OPK
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/games/opk
	$(HOST_DIR)/usr/bin/mksquashfs $(GNUBOY_PKGDIR)/opk/gb $(TARGET_DIR)/usr/games/opk/gb_gnuboy_funkey-s.opk -all-root -noappend -no-exports -no-xattrs
	$(HOST_DIR)/usr/bin/mksquashfs $(GNUBOY_PKGDIR)/opk/gbc $(TARGET_DIR)/usr/games/opk/gbc_gnuboy_funkey-s.opk -all-root -noappend -no-exports -no-xattrs
endef
GNUBOY_POST_INSTALL_TARGET_HOOKS += GNUBOY_CREATE_OPK

$(eval $(autotools-package))
