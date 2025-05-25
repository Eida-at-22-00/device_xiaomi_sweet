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
# Camera Flags.
AXION_CAMERA_REAR_INFO := 108,8,5,2
AXION_CAMERA_FRONT_INFO := 16

# Device Maintainer
AXION_MAINTAINER := Eida_Won

# Processor Info Flags.
AXION_PROCESSOR := Snapdragon_732G_(8_nm)
AXION_CPU_SMALL_CORES := 0,1,2,3,4,5
AXION_CPU_BIG_CORES := 6,7
AXION_CPU_BG := 0-2
AXION_CPU_FG := 0-5
AXION_CPU_LIMIT_BG := 0-1
BYPASS_CHARGE_SUPPORTED := true

# Misc
TARGET_DISABLE_EPPE := true
TARGET_ENABLE_BLUR := false
TARGET_INCLUDE_VIPERFX := true
TARGET_PREBUILT_BCR := false

PRODUCT_NAME := lineage_sweet
PRODUCT_DEVICE := sweet
PRODUCT_MANUFACTURER := Xiaomi
PRODUCT_BRAND := Redmi
PRODUCT_MODEL := M2101K6G

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="sweet_global-user 13 RKQ1.210614.002 V14.0.9.0.TKFMIXM release-keys" \
    BuildFingerprint=Redmi/sweet_global/sweet:13/RKQ1.210614.002/V14.0.9.0.TKFMIXM:user/release-keys
