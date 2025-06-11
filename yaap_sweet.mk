#
# Copyright (C) 2021-2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
TARGET_SUPPORTS_OMX_SERVICE := false
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from sweet device-makefile.
$(call inherit-product, device/xiaomi/sweet/device.mk)

# Inherit some common YAAP stuff.
$(call inherit-product, vendor/yaap/config/common_full_phone.mk)

# YAAP
TARGET_BUILD_GAPPS := true
TARGET_ENABLE_BLUR := false

# Device identifier. This must come after all inclusions.
PRODUCT_NAME := lineage_sweet
PRODUCT_DEVICE := sweet
PRODUCT_MANUFACTURER := Xiaomi
PRODUCT_BRAND := Redmi
PRODUCT_MODEL := M2101K6G

WITH_GMS := true
PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="sweet_global-user 13 RKQ1.210614.002 V14.0.9.0.TKFMIXM release-keys" \
    BuildFingerprint=Redmi/sweet_global/sweet:13/RKQ1.210614.002/V14.0.9.0.TKFMIXM:user/release-keys
