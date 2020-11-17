################################################################################
#
# mednafen
#
################################################################################

MEDNAFEN_VERSION = mednafen-git-FunKey-0.99
MEDNAFEN_SITE_METHOD = git
MEDNAFEN_SITE = https://github.com/FunKey-Project/mednafen-git.git
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

#MEDNAFEN_AUTORECONF = YES

MEDNAFEN_CFLAGS += -ggdb -O3

#MEDNAFEN_LDFLAGS +=  -lSDL_ttf -lSDL_image

MEDNAFEN_CONF_OPTS += CFLAGS="$(MEDNAFEN_CFLAGS)"
#MEDNAFEN_CONF_OPTS += LDFLAGS="$(MEDNAFEN_LDFLAGS)"
MEDNAFEN_CONF_OPTS += --prefix=/usr/local --bindir=/usr/games --without-libsndfile

MEDNAFEN_CONF_ENV += SDL_CONFIG="$(STAGING_DIR)/usr/bin/sdl-config"

$(eval $(autotools-package))
