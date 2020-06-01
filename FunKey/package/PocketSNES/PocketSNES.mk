################################################################################
#
# PocketSNES
#
################################################################################

POCKETSNES_VERSION = 70450b294133f658d3a281946a735d00cd02e7a3
POCKETSNES_SITE_METHOD = git
POCKETSNES_SITE = ssh://git@fk/FunKey-Project/FunKey-Emulator-PocketSNES
POCKETSNES_LICENSE = GPL-2.0
POCKETSNES_LICENSE_FILES = COPYING

POCKETSNES_DEPENDENCIES = sdl sdl_image sdl_mixer sdl_ttf zlib

POCKETSNES_CFLAGS = $(TARGET_CFLAGS)

ifeq ($(BR2_ARM_CPU_ARMV7A),y)
POCKETSNES_CFLAGS += -march=armv7-a
endif

ifeq ($(BR2_GCC_TARGET_CPU),"cortex-a7")
POCKETSNES_CFLAGS += -mtune=cortex-a7
endif

ifeq ($(BR2_GCC_TARGET_FLOAT_ABI),"hard")
POCKETSNES_CFLAGS += -mfloat-abi=hard -ffast-math -funsafe-math-optimizations
else ifeq ($(BR2_GCC_TARGET_FLOAT_ABI),"soft")
POCKETSNES_CFLAGS += -mfloat-abi=soft -ffast-math -funsafe-math-optimizations
endif

ifeq ($(BR2_ARM_CPU_HAS_NEON),y)
POCKETSNES_CFLAGS += -D__ARM_NEON__ -mfpu=neon -mvectorize-with-neon-quad
endif

POCKETSNES_SDL_CFLAGS += $(shell $(STAGING_DIR)/usr/bin/sdl-config --cflags)
POCKETSNES_SDL_LIBS += $(shell $(STAGING_DIR)/usr/bin/sdl-config --libs)

POCKETSNES_INCLUDE = -I pocketsnes \
		-I sal/linux/include -I sal/include \
		-I pocketsnes/include \
		-I menu -I pocketsnes/linux -I pocketsnes/snes9x

POCKETSNES_CFLAGS += -ggdb -O3
POCKETSNES_CFLAGS += -fomit-frame-pointer -fomit-frame-pointer -fexpensive-optimizations
POCKETSNES_CFLAGS += $(POCKETSNES_INCLUDE)
POCKETSNES_CFLAGS += $(POCKETSNES_SDL_CFLAGS)
POCKETSNES_CFLAGS += -DRC_OPTIMIZED -D__LINUX__ -D__DINGUX__ -DNO_ROM_BROWSER -DGCW_ZERO

POCKETSNES_CXXFLAGS += $(POCKETSNES_INCLUDE)
POCKETSNES_CXXFLAGS += -fno-exceptions -fno-rtti

POCKETSNES_LDFLAGS += -s -fprofile-generate -fprofile-dir=/home/retrofw/profile/pocket_snes \
	-fno-strict-aliasing 

POCKETSNES_LDFLAGS +=  $(POCKETSNES_SDL_LIBS)
POCKETSNES_LDFLAGS += -lgcc -lpthread -lSDL_image -lSDL_ttf -lpng  -lm -lz

define POCKETSNES_BUILD_CMDS
	(cd $(@D); \
	make \
	CFLAGS='$(POCKETSNES_CFLAGS)' \
	CXXFLAGS='$(POCKETSNES_CXXFLAGS)' \
	LDFLAGS='$(POCKETSNES_LDFLAGS)' \
	CC='$(TARGET_CC)' \
	CXX='$(TARGET_CXX)' \
	)
endef

define POCKETSNES_INSTALL_TARGET_CMDS
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/games
	$(INSTALL) -m 0755 $(@D)/psnes $(TARGET_DIR)/usr/games/psnes
endef

$(eval $(generic-package))
