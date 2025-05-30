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

# Inherit some common LineageOS stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# AxionAOSP Specific Flags.
AXION_MAINTAINER := Eida_Won_&_Johan_Liebert
AXION_PROCESSOR := Snapdragon_732G_(8_nm)

# Camera
AXION_CAMERA_REAR_INFO := 108,8,5,2
AXION_CAMERA_FRONT_INFO := 16

# CPU
AXION_CPU_SMALL_CORES := 0,1,2,3,4,5
AXION_CPU_BIG_CORES := 6,7
AXION_CPU_BG := 0-2
AXION_CPU_FG := 0-7
AXION_CPU_LIMIT_BG := 0-1
AXION_CPU_UNLIMIT_UI := 0-7
AXION_CPU_LIMIT_UI := 0-6

# Bypass Charging
BYPASS_CHARGE_SUPPORTED := true

TARGET_DISABLE_EPPE := true
TARGET_ENABLE_BLUR := false
TARGET_INCLUDE_VIPERFX := true
TARGET_FACE_UNLOCK_SUPPORTED := true

# Lineage Prebuilts
PRODUCT_PACKAGES += \
    Jelly \
    Glimpse \
    Dialer

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
