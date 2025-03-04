#
# Copyright (C) 2020 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

RELEASE_GOOGLE_BOOTLOADER_ORIOLE_DIR ?= pdk# Keep this for pdk TODO: b/327119000
RELEASE_GOOGLE_PRODUCT_BOOTLOADER_DIR := bootloader/$(RELEASE_GOOGLE_BOOTLOADER_ORIOLE_DIR)
$(call soong_config_set,raviole_bootloader,prebuilt_dir,$(RELEASE_GOOGLE_BOOTLOADER_ORIOLE_DIR))

# Keeps flexibility for kasan and ufs builds
TARGET_KERNEL_DIR ?= $(RELEASE_KERNEL_ORIOLE_DIR)
TARGET_BOARD_KERNEL_HEADERS ?= $(RELEASE_KERNEL_ORIOLE_DIR)/kernel-headers

$(call inherit-product-if-exists, vendor/google_devices/raviole/prebuilts/device-vendor-whitefin.mk)
$(call inherit-product-if-exists, vendor/google_devices/gs101/prebuilts/device-vendor.mk)
$(call inherit-product-if-exists, vendor/google_devices/gs101/proprietary/device-vendor.mk)
$(call inherit-product-if-exists, vendor/google_devices/raviole/proprietary/whitefin/device-vendor-whitefin.mk)

DEVICE_PACKAGE_OVERLAYS += device/google/raviole/whitefin/overlay

include device/google/gs101/device-common.mk
include hardware/google/pixel/vibrator/drv2624/device.mk
include device/google/raviole/audio/whitefin/audio-tables.mk
include device/google/gs-common/bcmbt/bluetooth.mk
include device/google/gs-common/gps/brcm/cbd_gps.mk
include device/google/gs-common/touch/lsi/lsi.mk

# wireless_charger HAL service needs to be included specially due to no raviole-sepolicy folder
PRODUCT_PACKAGES += vendor.google.wireless_charger-default
DEVICE_PRODUCT_COMPATIBILITY_MATRIX_FILE += device/google/gs-common/wireless_charger/compatibility_matrix.xml

# go/lyric-soong-variables
$(call soong_config_set,lyric,camera_hardware,slider)
$(call soong_config_set,lyric,tuning_product,slider)
$(call soong_config_set,google3a_config,target_device,slider)

# Init files
PRODUCT_COPY_FILES += \
	device/google/raviole/conf/init.whitefin.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.whitefin.rc

# Recovery files
PRODUCT_COPY_FILES += \
	device/google/gs101/conf/init.recovery.device.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.whitefin.rc

# insmod files
PRODUCT_COPY_FILES += \
	device/google/raviole/init.insmod.whitefin.cfg:$(TARGET_COPY_OUT_VENDOR)/etc/init.insmod.whitefin.cfg

# Thermal Config
PRODUCT_COPY_FILES += \
    device/google/raviole/thermal_info_config_whitefin.json:$(TARGET_COPY_OUT_VENDOR)/etc/thermal_info_config.json

# Camera
PRODUCT_COPY_FILES += \
    device/google/raviole/media_profiles_whitefin.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_V1_0.xml

# Bluetooth
PRODUCT_PROPERTY_OVERRIDES += \
    ro.bluetooth.a2dp_offload.supported=false

PRODUCT_PRODUCT_PROPERTIES += \
    persist.bluetooth.a2dp_aac.vbr_supported=true

# NFC
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.nfc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.xml \
	frameworks/native/data/etc/android.hardware.nfc.hce.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.hce.xml \
	frameworks/native/data/etc/android.hardware.nfc.hcef.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.hcef.xml \
	frameworks/native/data/etc/com.nxp.mifare.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/com.nxp.mifare.xml \
	frameworks/native/data/etc/android.hardware.nfc.uicc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.uicc.xml \
	frameworks/native/data/etc/android.hardware.se.omapi.uicc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.se.omapi.uicc.xml \
	device/google/raviole/nfc/libnfc-hal-st.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libnfc-hal-st.conf \
	device/google/raviole/nfc/libnfc-nci.conf:$(TARGET_COPY_OUT_PRODUCT)/etc/libnfc-nci.conf

PRODUCT_PACKAGES += \
	$(RELEASE_PACKAGE_NFC_STACK) \
	Tag \
	android.hardware.nfc-service.st

# PowerStats HAL
PRODUCT_SOONG_NAMESPACES += device/google/raviole/powerstats/whitefin

# Trusty liboemcrypto.so
PRODUCT_SOONG_NAMESPACES += vendor/google_devices/raviole/prebuilts

# tetheroffload HAL
PRODUCT_PACKAGES += \
	vendor.samsung_slsi.hardware.tetheroffload@1.1-service

# Power HAL config
PRODUCT_COPY_FILES += \
	device/google/raviole/powerhint-whitefin.json:$(TARGET_COPY_OUT_VENDOR)/etc/powerhint.json

# This device is shipped with 31 (Android S)
PRODUCT_SHIPPING_API_LEVEL := 31

# Device features
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/handheld_core_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/handheld_core_hardware.xml

# Location
ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
        PRODUCT_COPY_FILES += \
		device/google/raviole/location/gps.xml:$(TARGET_COPY_OUT_VENDOR)/etc/gnss/gps.xml
else
        PRODUCT_COPY_FILES += \
		device/google/raviole/location/gps_user.xml:$(TARGET_COPY_OUT_VENDOR)/etc/gnss/gps.xml
endif

# Disable AVF Remote Attestation
PRODUCT_AVF_REMOTE_ATTESTATION_DISABLED := true
