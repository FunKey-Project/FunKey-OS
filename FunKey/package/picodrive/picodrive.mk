################################################################################
#
# picodrive
#
################################################################################

PICODRIVE_VERSION = 75f0469daf5a640811564441d36d83456cf9c9c6
PICODRIVE_SITE_METHOD = git
PICODRIVE_SITE = ssh://git@fk/FunKey-Project/FunKey-Emulator-picodrive
PICODRIVE_LICENSE = MAME
PICODRIVE_LICENSE_FILES = COPYING

PICODRIVE_DEPENDENCIES = sdl sdl_image sdl_mixer sdl_ttf zlib

PICODRIVE_CFLAGS = $(TARGET_CFLAGS)

ifeq ($(BR2_ARM_CPU_ARMV7A),y)
PICODRIVE_CFLAGS += -march=armv7-a
endif

ifeq ($(BR2_GCC_TARGET_CPU),"cortex-a7")
PICODRIVE_CFLAGS += -mtune=cortex-a7
endif

ifeq ($(BR2_GCC_TARGET_FLOAT_ABI),"hard")
PICODRIVE_CFLAGS += -mfloat-abi=hard -ffast-math -funsafe-math-optimizations
else ifeq ($(BR2_GCC_TARGET_FLOAT_ABI),"soft")
PICODRIVE_CFLAGS += -mfloat-abi=soft -ffast-math -funsafe-math-optimizations
endif

ifeq ($(BR2_ARM_CPU_HAS_NEON),y)
PICODRIVE_CFLAGS += -D__ARM_NEON__ -mfpu=neon -mvectorize-with-neon-quad
endif

PICODRIVE_CONF_OPTS += --platform=generic --sound-drivers=sdl
PICODRIVE_CFLAGS += -ggdb -O3

PICODRIVE_LIBS += -lSDL_image -lSDL_ttf

define PICODRIVE_CONFIGURE_CMDS
	(cd $(@D); \
	chmod +x configure; \
	sed -i -e 's/-mcpu/-mtune/g' configure; \
	CFLAGS='$(PICODRIVE_CFLAGS)' \
	CROSS_COMPILE=$(TARGET_CROSS) \
	LDFLAGS='-L$(TARGET_DIR)/usr/lib' \
	LDLIBS='$(PICODRIVE_LIBS)'\
	./configure $(PICODRIVE_CONF_OPTS) \
	)
endef

define PICODRIVE_BUILD_CMDS
	(cd $(@D); \
	make \
	)
endef

define PICODRIVE_INSTALL_TARGET_CMDS
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/games
	$(INSTALL) -m 0755 $(@D)/PicoDrive $(TARGET_DIR)/usr/games/
endef


$(eval $(generic-package))
