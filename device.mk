#
# Copyright (C) 2021-2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from sm6150-common
$(call inherit-product, device/xiaomi/sm6150-common/sm6150.mk)

# MiuiCamera
$(call inherit-product-if-exists, device/xiaomi/miuicamera-sweet/device.mk)

# AAPT
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

# API level, the device has been commercially launched on
PRODUCT_SHIPPING_API_LEVEL := 30

# Audio
PRODUCT_PACKAGES += \
    sku_sweet_audio_symlink

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/audio/audio_platform_info_intcodec.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_platform_info_intcodec.xml \
    $(LOCAL_PATH)/configs/audio/mixer_paths_idp.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths_idp.xml \
    $(LOCAL_PATH)/configs/audio/mixer_paths_overlay_dynamic.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths_overlay_dynamic.xml \
    $(LOCAL_PATH)/configs/audio/mixer_paths_overlay_static.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths_overlay_static.xml

# Bootanimation
TARGET_BOOT_ANIMATION_RES := 1080
TARGET_SCREEN_WIDTH := 1080
TARGET_SCREEN_HEIGHT := 2400

# Device-specific settings
PRODUCT_PACKAGES += \
    XiaomiParts \
    XiaomiDolby \
    XiaomiDolbyOverlay \
    DSPVolumeSynchronizer

# Display
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/display/qdcm_calib_data_xiaomi_k6_38_0c_0a_fhd_dsc_video_dsi_panel.xml:$(TARGET_COPY_OUT_VENDOR)/etc/qdcm_calib_data_xiaomi_k6_38_0c_0a_fhd_dsc_video_dsi_panel.xml \
    $(LOCAL_PATH)/configs/display/qdcm_calib_data_xiaomi_k6_38_0e_0b_fhd_dsc_video_dsi_panel.xml:$(TARGET_COPY_OUT_VENDOR)/etc/qdcm_calib_data_xiaomi_k6_38_0e_0b_fhd_dsc_video_dsi_panel.xml

PRODUCT_PACKAGES += \
    hwcomposer.sweet

# Dolby
TARGET_USES_DOLBY := true

# Init scripts
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/init.sweet.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.sweet.rc

# NFC
PRODUCT_PACKAGES += \
    com.android.nfc_extras \
    Tag

PRODUCT_PACKAGES += \
    android.hardware.nfc-service.nxp

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.nfc.hcef.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_sweet/android.hardware.nfc.hcef.xml \
    frameworks/native/data/etc/android.hardware.nfc.hce.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_sweet/android.hardware.nfc.hce.xml \
    frameworks/native/data/etc/android.hardware.nfc.uicc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_sweet/android.hardware.nfc.uicc.xml \
    frameworks/native/data/etc/android.hardware.nfc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_sweet/android.hardware.nfc.xml \
    frameworks/native/data/etc/android.hardware.se.omapi.uicc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_sweet/android.hardware.se.omapi.uicc.xml \
    frameworks/native/data/etc/com.android.nfc_extras.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_sweet/com.android.nfc_extras.xml \
    frameworks/native/data/etc/com.nxp.mifare.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_sweet/com.nxp.mifare.xml

# IR
PRODUCT_PACKAGES += \
    android.hardware.ir-service.lineage

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.consumerir.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.consumerir.xml

# Overlay
DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay

PRODUCT_PACKAGES += \
    FrameworksResOverlay \
    SettingsProviderM2101K6G \
    SettingsProviderM2101K6I \
    WifiResM2101K6G \
    WifiResM2101K6I

# Power
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/power/powerhint.json:$(TARGET_COPY_OUT_VENDOR)/etc/powerhint.json

# Sensors
PRODUCT_PACKAGES += \
    android.hardware.sensors@1.0-impl \
    android.hardware.sensors@1.0-service

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# System properties
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/properties/build_GLOBAL.prop:$(TARGET_COPY_OUT_ODM)/etc/build_GLOBAL.prop \
    $(LOCAL_PATH)/properties/build_INDIA-pro.prop:$(TARGET_COPY_OUT_ODM)/etc/build_INDIA-pro.prop \
    $(LOCAL_PATH)/properties/build_INDIA-std.prop:$(TARGET_COPY_OUT_ODM)/etc/build_INDIA-std.prop \
    $(LOCAL_PATH)/properties/build_JAPAN.prop:$(TARGET_COPY_OUT_ODM)/etc/build_JAPAN.prop

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/properties/build_GLOBAL.prop:$(TARGET_COPY_OUT_RECOVERY)/root/build_GLOBAL.prop \
    $(LOCAL_PATH)/properties/build_INDIA-pro.prop:$(TARGET_COPY_OUT_RECOVERY)/root/build_INDIA-pro.prop \
    $(LOCAL_PATH)/properties/build_INDIA-std.prop:$(TARGET_COPY_OUT_RECOVERY)/root/build_INDIA-std.prop \
    $(LOCAL_PATH)/properties/build_JAPAN.prop:$(TARGET_COPY_OUT_RECOVERY)/root/build_JAPAN.prop

# Vendor service manager
PRODUCT_PACKAGES += \
    vndservicemanager

# Call the proprietary setup
$(call inherit-product, vendor/xiaomi/sweet/sweet-vendor.mk)
