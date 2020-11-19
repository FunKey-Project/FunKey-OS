################################################################################
#
# FCEUX
#
################################################################################

FCEUX_VERSION = fceux-FunKey-1.00
FCEUX_SITE_METHOD = git
FCEUX_SITE = https://github.com/FunKey-Project/fceux.git
FCEUX_LICENSE = GPL-2.0
FCEUX_LICENSE_FILES = COPYING

FCEUX_DEPENDENCIES = sdl sdl_image sdl_mixer sdl_ttf zlib

FCEUX_CFLAGS = $(TARGET_CFLAGS)

ifeq ($(BR2_ARM_CPU_ARMV7A),y)
FCEUX_CFLAGS += -march=armv7-a
endif

ifeq ($(BR2_GCC_TARGET_CPU),"cortex-a7")
FCEUX_CFLAGS += -mtune=cortex-a7
endif

ifeq ($(BR2_GCC_TARGET_FLOAT_ABI),"hard")
FCEUX_CFLAGS += -mfloat-abi=hard -ffast-math -funsafe-math-optimizations
else ifeq ($(BR2_GCC_TARGET_FLOAT_ABI),"soft")
FCEUX_CFLAGS += -mfloat-abi=soft -ffast-math -funsafe-math-optimizations
endif

ifeq ($(BR2_ARM_CPU_HAS_NEON),y)
FCEUX_CFLAGS += -D__ARM_NEON__ -mfpu=neon -mvectorize-with-neon-quad
endif

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


$(eval $(generic-package))
