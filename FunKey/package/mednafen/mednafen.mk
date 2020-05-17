################################################################################
#
# mednafen
#
################################################################################

#MEDNAFEN_VERSION = 0.9.48
#MEDNAFEN_SOURCE = mednafen-$(MEDNAFEN_VERSION).tar.xz
#MEDNAFEN_SITE = http://downloads.sourceforge.net/sourceforge/mednafen
MEDNAFEN_VERSION = f8407499b30099817a762d98499f1e885125c6a2
MEDNAFEN_SITE_METHOD = git
MEDNAFEN_SITE = ssh://git@fk/FunKey-Project/FunKey-Emulator-mednafen-0.9.48
MEDNAFEN_LICENSE = GPL-2.0+
MEDNAFEN_LICENSE_FILES = COPYING

MEDNAFEN_DEPENDENCIES = sdl sdl_image sdl_mixer sdl_ttf zlib

MEDNAFEN_CFLAGS = $(TARGET_CFLAGS) -ggdb -O3 -ftree-vectorize
ifeq ($(BR2_PACKAGE_MEDNAFEN_FAST),y)
MEDNAFEN_CFLAGS += -ffast-math -funsafe-math-optimizations

endif
ifeq ($(BR2_ARM_CPU_HAS_NEON),y)
MEDNAFEN_CFLAGS += -D__ARM_NEON__ -mfpu=neon -mvectorize-with-neon-quad
endif

MEDNAFEN_CONF_OPTS += CFLAGS="$(MEDNAFEN_CFLAGS)"
MEDNAFEN_CONF_OPTS += --without-libsndfile

MEDNAFEN_CONF_ENV += SDL_CONFIG="$(STAGING_DIR)/usr/bin/sdl-config"

$(eval $(autotools-package))
