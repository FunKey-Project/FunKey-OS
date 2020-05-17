################################################################################
#
# PCSX-ReARMed
#
################################################################################

PCSX_REARMED_VERSION = 88cbb9aa737a19feaca1c31290f0cdbf41d3ae95
PCSX_REARMED_SITE_METHOD = git
PCSX_REARMED_SITE = ssh://git@fk/FunKey-Project/FunKey-Emulator-PCSX-ReARMed
PCSX_REARMED_LICENSE = GPL-2.0
PCSX_REARMED_LICENSE_FILES = COPYING

PCSX_REARMED_DEPENDENCIES = sdl sdl_image sdl_mixer sdl_ttf zlib

PCSX_REARMED_CFLAGS = $(TARGET_CFLAGS) -ggdb -O3 -ftree-vectorize
ifeq ($(BR2_PACKAGE_PCSX_REARMED_FAST),y)
PCSX_REARMED_CFLAGS += -ffast-math -funsafe-math-optimizations

endif
ifeq ($(BR2_ARM_CPU_HAS_NEON),y)
PCSX_REARMED_CFLAGS += -D__ARM_NEON__ -mfpu=neon -mvectorize-with-neon-quad
PCSX_REARMED_CONF_OPTS += --enable-neon --gpu=neon
endif

PCSX_REARMED_CONF_OPTS += --sound-drivers=sdl

define PCSX_REARMED_CONFIGURE_CMDS
	(cd $(@D); \
	chmod +x configure; \
	sed -i 's/sdl-config/$$SDL_CONFIG/g' configure; \
	rm -f skin; \
	CFLAGS='$(PCSX_REARMED_CFLAGS)' \
	CROSS_COMPILE=$(TARGET_CROSS) \
	LDFLAGS='-L$(TARGET_DIR)/usr/lib' \
	SDL_CONFIG='$(STAGING_DIR)/usr/bin/sdl-config' \
	./configure $(PCSX_REARMED_CONF_OPTS) \
	)
endef

define PCSX_REARMED_BUILD_CMDS
	(cd $(@D); \
	make \
	)
endef

define PCSX_REARMED_INSTALL_TARGET_CMDS
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/games
	$(INSTALL) -m 0755 $(@D)/pcsx $(TARGET_DIR)/usr/games/pcsx
endef


$(eval $(generic-package))
