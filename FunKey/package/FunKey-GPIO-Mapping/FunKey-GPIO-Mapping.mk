################################################################################
#
# FunKey-GPIO-mapping
#
################################################################################

FUNKEY_GPIO_MAPPING_VERSION = 82276e6ebec09c15009d481a9be55541ba3c30f1
FUNKEY_GPIO_MAPPING_SITE_METHOD = git
#FUNKEY_GPIO_MAPPING_SITE = ssh://git@github.com/FunKey-Project/FunKey-GPIO-Mapping.git
FUNKEY_GPIO_MAPPING_SITE = ssh://git@fk/FunKey-Project/FunKey-GPIO-Mapping.git
FUNKEY_GPIO_MAPPING_SITE_LICENSE = GPL-2.1+
FUNKEY_GPIO_MAPPING_SITE_LICENSE_FILES = COPYING

define FUNKEY_GPIO_MAPPING_BUILD_CMDS
	$(TARGET_MAKE_ENV) CROSS_COMPILE=$(TARGET_CROSS) \
		CC="$(TARGET_CC)" \
		$(MAKE) -C $(@D) \
		CFLAGS="$(TARGET_CFLAGS)" $(FUNKEY_GPIO_MAPPING_BUILD_TARGET)
endef

define FUNKEY_GPIO_MAPPING_INSTALL_TARGET_CMDS
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/local/sbin
	$(INSTALL) -m 0755 $(@D)/funkey_gpio_management $(TARGET_DIR)/usr/local/sbin/funkey_gpio_manag
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/etc
	$(INSTALL) -m 0644 $(@D)/funkey_gpio_mapping.conf $(TARGET_DIR)/etc/funkey_gpio_mapping.conf
endef

$(eval $(generic-package))
