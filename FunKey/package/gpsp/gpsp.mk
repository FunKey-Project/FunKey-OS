################################################################################
#
# gpsp
#
################################################################################

GPSP_VERSION = b769f202bed9b312298f5943b8d8790efc9e099d
GPSP_SITE_METHOD = git
GPSP_SITE = ssh://git@fk/FunKey-Project/FunKey-Emulator-GPSP
GPSP_LICENSE = GPL-2.0
GPSP_LICENSE_FILES = COPYING.DOC

GPSP_DEPENDENCIES = sdl sdl_image sdl_mixer sdl_ttf zlib

GPSP_CFLAGS = $(TARGET_CFLAGS)

ifeq ($(BR2_ARM_CPU_ARMV7A),y)
GPSP_CFLAGS += -march=armv7-a
endif

ifeq ($(BR2_GCC_TARGET_CPU),"cortex-a7")
GPSP_CFLAGS += -mtune=cortex-a7
endif

ifeq ($(BR2_GCC_TARGET_FLOAT_ABI),"hard")
GPSP_CFLAGS += -mfloat-abi=hard -ffast-math -funsafe-math-optimizations
else ifeq ($(BR2_GCC_TARGET_FLOAT_ABI),"soft")
GPSP_CFLAGS += -mfloat-abi=soft -ffast-math -funsafe-math-optimizations
endif

ifeq ($(BR2_ARM_CPU_HAS_NEON),y)
GPSP_CFLAGS += -D__ARM_NEON__ -mfpu=neon -mvectorize-with-neon-quad
endif

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

$(eval $(generic-package))
