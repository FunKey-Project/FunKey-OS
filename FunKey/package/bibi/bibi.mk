################################################################################
#
# bibi
#
################################################################################

BIBI_VERSION = Bibi-FunKey-1.0.0
BIBI_SITE_METHOD = git
BIBI_SITE = https://github.com/FunKey-Project/Bibi.git
BIBI_SITE_LICENSE = GPL-2.1+
BIBI_SITE_LICENSE_FILES = COPYING

BIBI_DEPENDENCIES = sdl sdl_image sdl_ttf

BIBI_CFLAGS = $(TARGET_CFLAGS)

BIBI_SDL_CFLAGS += $(shell $(STAGING_DIR)/usr/bin/sdl-config --cflags)
BIBI_SDL_LIBS += $(shell $(STAGING_DIR)/usr/bin/sdl-config --libs)
BIBI_SDL_CFLAGS += $(shell $(STAGING_DIR)/usr/bin/libmikmod-config --cflags)
BIBI_SDL_LIBS += $(shell $(STAGING_DIR)/usr/bin/libmikmod-config --libs)

BIBI_CFLAGS += -ggdb -O3
BIBI_CFLAGS += $(BIBI_SDL_CFLAGS)
BIBI_CFLAGS += -DFUNKEY -DHW_SCREEN_RESIZE -DSOUND_SDL_ACTIVATED -DBYPASS_MENU -DFUNKEY_MENU

BIBI_LIBS += $(BIBI_SDL_LIBS)
BIBI_LIBS += -lSDL -lSDL_ttf -lSDL_image -lSDL_mixer

define BIBI_BUILD_CMDS
	(cd $(@D); \
	make \
	CROSS_COMPILE=$(TARGET_CROSS) \
	CFLAGS='$(BIBI_CFLAGS)' \
	LDFLAGS='$(BIBI_LIBS)' \
	SDL_INCLUDES='$(BIBI_SDL_CFLAGS)' \
	SDL_LIBS='$(BIBI_SDL_LIBS)' \
	)
endef

define BIBI_INSTALL_TARGET_CMDS
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/games/bibi
	$(INSTALL) -m 0755 $(@D)/bibi $(TARGET_DIR)/usr/games/bibi/bibi
	$(INSTALL) -D -m 0755 -t $(TARGET_DIR)/usr/games/bibi/sprite $(@D)/sprite/* 
	$(INSTALL) -D -m 0755 -t $(TARGET_DIR)/usr/games/bibi/data $(@D)/data/* 
	$(INSTALL) -D -m 0755 -t $(TARGET_DIR)/usr/games/bibi/audio $(@D)/audio/* 
endef

$(eval $(generic-package))
