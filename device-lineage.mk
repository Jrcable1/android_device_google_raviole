#
# Copyright (C) 2021 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Scudo
PRODUCT_USE_SCUDO := true

DISABLE_ARTIFACT_PATH_REQUIREMENTS:= true

PRODUCT_BROKEN_VERIFY_USES_LIBRARIES := true

# Overlays
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay-lineage

# ANGLE - Almost Native Graphics Layer Engine
PRODUCT_PACKAGES += \
    ANGLE

# EUICC
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.telephony.euicc.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/android.hardware.telephony.euicc.xml

# Kernel
TARGET_PREBUILT_KERNEL := device/google/raviole-kernel/Image.lz4

# PixelParts (HBM)
include packages/apps/PixelParts/device.mk

# PowerShare
include hardware/google/pixel/powershare/device.mk

# wireless_charger HAL service
include device/google/gs-common/wireless_charger/wireless_charger.mk

# GAPPS
WITH_GMS := true
TARGET_DEFAULT_PIXEL_LAUNCHER := true
TARGET_PREBUILT_LAWNCHAIR_LAUNCHER := true

# RisingOS variables
RISING_BUILDTYPE := OFFICIAL
LINEAGE_DISPLAY_VERSION=
RISING_DISPLAY_VERSION=
RISING_MAINTAINER="Jrcable2"
RISING_CHIPSET := GS101
RISING_RAM := 12gb
RISING_CHIPSET := Tensor
RISING_BATTERY := 5003mah
RISING_DISPLAY := 3120×1440
TARGET_PIXEL_BOOT_ANIMATION_RES := 1440
TARGET_BOOT_ANIMATION_RES := 1440
TARGET_HAS_UDFPS := true
TARGET_ENABLE_PRIVAPP_ENFORCEMENT := false
TARGET_ENABLE_BLUR := true
TARGET_FACE_UNLOCK_SUPPORTED := true
TARGET_USE_PIXEL_FINGERPRINT := true
TARGET_SUPPORTS_NEXT_GEN_ASSISTANT := true
TARGET_EXCLUDES_AUDIOFX := true																																																																																																																																																		TARGET_COMPRESSED_SOONG_ZIP := true
TARGET_IS_PIXEL := true
TARGET_IS_PIXEL_6 := true
TARGET_PIXEL_STAND_SUPPORTED := true

# Build necessary packages for vendor

# Codec2
PRODUCT_PACKAGES += \
    libexynosv4l2

# Fingerprint
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.fingerprint.xml

# Graphics
PRODUCT_PACKAGES += \
    libEGL_angle \
    libGLESv1_CM_angle \
    libGLESv2_angle

# Identity credential
PRODUCT_PACKAGES += \
    android.hardware.identity_credential.xml

# Sensors
PRODUCT_PACKAGES += \
    sensors.dynamic_sensor_hal
