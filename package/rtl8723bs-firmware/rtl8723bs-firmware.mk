################################################################################
#
# rtl8723bs-firmware
#
################################################################################

RTL8723BS_FIRMWARE_VERSION = cc77e7b6092c54500058cd027b679421b9399905
RTL8723BS_FIRMWARE_SITE = $(call github,hadess,rtl8723bs,$(RTL8723BS_FIRMWARE_VERSION))
RTL8723BS_FIRMWARE_LICENSE = GPL-2.0, proprietary (*.bin firmware blobs)

RTL8723BS_FIRMWARE_BINS = rtl8723bs_ap_wowlan.bin rtl8723bs_wowlan.bin \
	rtl8723bs_bt.bin rtl8723bs_nic.bin

define RTL8723BS_FIRMWARE_INSTALL_FIRMWARE
	$(foreach bin, $(RTL8723BS_FIRMWARE_BINS), \
		$(INSTALL) -D -m 644 $(@D)/$(bin) $(TARGET_DIR)/lib/firmware/rtlwifi/$(bin)
	)
endef
RTL8723BS_FIRMWARE_POST_INSTALL_TARGET_HOOKS += RTL8723BS_INSTALL_FIRMWARE

$(eval $(generic-package))
