################################################################################
#
# PCSX-ReARMed
#
################################################################################

PCSX_REARMED_VERSION = ce405c0
PCSX_REARMED_SITE_METHOD = git
PCSX_REARMED_SITE = https://github.com/FunKey-Project/pcsx_rearmed.git
PCSX_REARMED_LICENSE = GPL-2.0
PCSX_REARMED_LICENSE_FILES = COPYING

PCSX_REARMED_DEPENDENCIES = sdl sdl_image sdl_mixer sdl_ttf zlib

PCSX_REARMED_CFLAGS = $(TARGET_CFLAGS) $(subst $\",,$(BR2_TARGET_OPTIMIZATION)) -mfloat-abi=hard -ffast-math -funsafe-math-optimizations

ifeq ($(BR2_ARM_CPU_HAS_NEON),y)
    PCSX_REARMED_CONF_OPTS += --enable-neon --gpu=neon
endif

PCSX_REARMED_CONF_OPTS += --sound-drivers=sdl
PCSX_REARMED_CFLAGS += -ggdb -O3

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

PCSX_REARMED_GIT_SUBMODULES = YES

define PCSX_REARMED_INSTALL_TARGET_CMDS
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/games
	$(INSTALL) -m 0755 $(@D)/pcsx $(TARGET_DIR)/usr/games/pcsx
endef

define PCSX_REARMED_CREATE_OPK
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/local/share/OPKs/Emulators
	$(HOST_DIR)/usr/bin/mksquashfs $(PCSX_REARMED_PKGDIR)/opk/ps1 $(TARGET_DIR)/usr/local/share/OPKs/Emulators/ps1_pcsx_funkey-s.opk -all-root -noappend -no-exports -no-xattrs
endef
PCSX_REARMED_POST_INSTALL_TARGET_HOOKS += PCSX_REARMED_CREATE_OPK

$(eval $(generic-package))
