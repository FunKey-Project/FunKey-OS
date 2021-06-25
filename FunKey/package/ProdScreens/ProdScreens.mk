################################################################################
#
# FunKey-Prod-screens
#
################################################################################

PRODSCREENS_VERSION = FunKey-ProdScreens-FunKey-1.1.2
PRODSCREENS_SITE_METHOD = git
PRODSCREENS_SITE = https://github.com/FunKey-Project/FunKey-ProdScreens.git
PRODSCREENS_SITE_LICENSE = GPL-2.1+
PRODSCREENS_SITE_LICENSE_FILES = COPYING

PRODSCREENS_DEPENDENCIES = sdl sdl_image sdl_ttf

PRODSCREENS_CFLAGS = $(TARGET_CFLAGS)

PRODSCREENS_SDL_CFLAGS += $(shell $(STAGING_DIR)/usr/bin/sdl-config --cflags)
PRODSCREENS_SDL_LIBS += $(shell $(STAGING_DIR)/usr/bin/sdl-config --libs)

PRODSCREENS_CFLAGS += -ggdb -O3
PRODSCREENS_CFLAGS += $(PRODSCREENS_SDL_CFLAGS)

PRODSCREENS_LIBS += $(PRODSCREENS_SDL_LIBS)
PRODSCREENS_LIBS += -lSDL -lSDL_ttf -lSDL_image 

define PRODSCREENS_BUILD_CMDS
	(cd $(@D); \
	make \
	CROSS_COMPILE=$(TARGET_CROSS) \
	CFLAGS='$(PRODSCREENS_CFLAGS)' \
	LIBS='$(PRODSCREENS_LIBS)' \
	)
endef

define PRODSCREENS_INSTALL_TARGET_CMDS
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/local/sbin
	$(INSTALL) -m 0755 $(@D)/funkey_prod_screens $(TARGET_DIR)/usr/local/sbin/funkey_prod_screens
	#$(INSTALL) -m 0755 $(@D)/ProdResources $(TARGET_DIR)/usr/local/sbin/ProdResources
endef

$(eval $(generic-package))
