#
# SPDX-FileCopyrightText: 2021-2024 The LineageOS Project
# SPDX-FileCopyrightText: 2021-2024 The Calyx Institute
# SPDX-License-Identifier: Apache-2.0
#

# Use 32-bit libc variant by default
PRODUCT_USE_SCUDO := true
PRODUCT_USE_SCUDO_32_BIT := true

DEVICE_PACKAGE_OVERLAYS += $(DEVICE_PATH)/overlay-lineage

# ANGLE - Almost Native Graphics Layer Engine
PRODUCT_PACKAGES += \
    ANGLE

# EUICC
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.telephony.euicc.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/android.hardware.telephony.euicc.xml

# PixelParts (HBM)
include packages/apps/PixelParts/device.mk

# PowerShare
include hardware/google/pixel/powershare/device.mk

# wireless_charger HAL service
include device/google/gs-common/wireless_charger/wireless_charger.mk

# RisingOS variables
RISING_MAINTAINER=Jrcable2
TARGET_ENABLE_BLUR := true
TARGET_HAS_UDFPS := true
TARGET_FACE_UNLOCK_SUPPORTED := true

# GAPPS
WITH_GMS := true

# Ship Pixel Launcher
TARGET_DEFAULT_PIXEL_LAUNCHER := true

# Ship LawnChair 
TARGET_PREBUILT_LAWNCHAIR_LAUNCHER := true

# Ship Google Camera
TARGET_PREBUILT_GOOGLE_CAMERA := true

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

# Sensors
PRODUCT_PACKAGES += \
    sensors.dynamic_sensor_hal
