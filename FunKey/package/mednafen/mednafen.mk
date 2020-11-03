################################################################################
#
# mednafen
#
################################################################################

#MEDNAFEN_VERSION = 0.9.48
#MEDNAFEN_SOURCE = mednafen-$(MEDNAFEN_VERSION).tar.xz
#MEDNAFEN_SITE = http://downloads.sourceforge.net/sourceforge/mednafen
MEDNAFEN_VERSION = e7ee7d0fb9438c2f3e132583b2d79eb0db7ebb91
MEDNAFEN_SITE_METHOD = git
MEDNAFEN_SITE = ssh://git@fk/FunKey-Project/FunKey-Emulator-mednafen-0.9.48
MEDNAFEN_LICENSE = GPL-2.0+
MEDNAFEN_LICENSE_FILES = COPYING

MEDNAFEN_DEPENDENCIES = sdl sdl_image sdl_mixer sdl_ttf zlib

MEDNAFEN_CFLAGS = $(TARGET_CFLAGS)

ifeq ($(BR2_ARM_CPU_ARMV7A),y)
MEDNAFEN_CFLAGS += -march=armv7-a
endif

ifeq ($(BR2_GCC_TARGET_CPU),"cortex-a7")
MEDNAFEN_CFLAGS += -mtune=cortex-a7
endif

ifeq ($(BR2_GCC_TARGET_FLOAT_ABI),"hard")
MEDNAFEN_CFLAGS += -mfloat-abi=hard -ffast-math -funsafe-math-optimizations
else ifeq ($(BR2_GCC_TARGET_FLOAT_ABI),"soft")
MEDNAFEN_CFLAGS += -mfloat-abi=soft -ffast-math -funsafe-math-optimizations
endif

ifeq ($(BR2_ARM_CPU_HAS_NEON),y)
MEDNAFEN_CFLAGS += -D__ARM_NEON__ -mfpu=neon -mvectorize-with-neon-quad
endif

MEDNAFEN_CFLAGS += -ggdb -O3

MEDNAFEN_CONF_OPTS += CFLAGS="$(MEDNAFEN_CFLAGS)"
MEDNAFEN_CONF_OPTS += --prefix=/usr/local --bindir=/usr/games --without-libsndfile

MEDNAFEN_CONF_ENV += SDL_CONFIG="$(STAGING_DIR)/usr/bin/sdl-config"

$(eval $(autotools-package))
