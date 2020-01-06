################################################################################
#
# funkey-gpio-mapping
#
################################################################################
#https://bitbucket.org/keymu2/funkey-gpio-mapping/get/1a98c2321961.zip
FUNKEY_GPIO_MAPPING_VERSION = 1a98c2321961
FUNKEY_GPIO_MAPPING_SOURCE = $(FUNKEY_GPIO_MAPPING_VERSION).zip
FUNKEY_GPIO_MAPPING_SITE = https://bitbucket.org/keymu2/funkey-gpio-mapping/get
FUNKEY_GPIO_MAPPING_SITE_LICENSE = GPL-2.1+
FUNKEY_GPIO_MAPPING_SITE_LICENSE_FILES = COPYING

define FUNKEY_GPIO_MAPPING_BUILD_CMDS
	$(TARGET_MAKE_ENV) CROSS_COMPILE=$(TARGET_CROSS) \
		CC="$(TARGET_CC)" \
		$(MAKE) -C $(@D) \
		CFLAGS="$(TARGET_CFLAGS)" $(FUNKEY_GPIO_MAPPING_BUILD_TARGET)
endef

define FUNKEY_GPIO_MAPPING_INSTALL_TARGET_CMDS
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/local/bin
	$(INSTALL) -m 0755 $(@D)/funkey_gpio_management $(TARGET_DIR)/usr/local/bin/funkey_gpio_management
endef

$(eval $(generic-package))
