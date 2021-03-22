PRODUCT_BRAND ?= Ancient-OS

ifeq ($(ANCIENT_GAPPS), true)
ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent
endif

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    dalvik.vm.debug.alloc=0 \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dataroaming=false \
    ro.com.android.dateformat=MM-dd-yyyy \
    persist.sys.disable_rescue=true \
    ro.setupwizard.rotation_locked=true

ifeq ($(TARGET_BUILD_VARIANT),eng)
# Disable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=0
else
# Enable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/ancient/prebuilt/common/bin/backuptool.sh:$(TARGET_COPY_OUT_SYSTEM)/install/bin/backuptool.sh \
    vendor/ancient/prebuilt/common/bin/backuptool.functions:$(TARGET_COPY_OUT_SYSTEM)/install/bin/backuptool.functions \
    vendor/ancient/prebuilt/common/bin/50-base.sh:$(TARGET_COPY_OUT_SYSTEM)/addon.d/50-base.sh

# OTA
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.ota.allow_downgrade=true
endif

ifneq ($(strip $(AB_OTA_PARTITIONS) $(AB_OTA_POSTINSTALL_CONFIG)),)
PRODUCT_COPY_FILES += \
    vendor/ancient/prebuilt/common/bin/backuptool_ab.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.sh \
    vendor/ancient/prebuilt/common/bin/backuptool_ab.functions:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.functions \
    vendor/ancient/prebuilt/common/bin/backuptool_postinstall.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_postinstall.sh
endif

# system mount
PRODUCT_COPY_FILES += \
    vendor/ancient/prebuilt/common/bin/system-mount.sh:$(TARGET_COPY_OUT_SYSTEM)/install/bin/system-mount.sh

# Some permissions
PRODUCT_COPY_FILES += \
    vendor/ancient/config/permissions/ancient-sysconfig.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/ancient-sysconfig.xml \
    vendor/ancient/config/permissions/backup.xml:system/etc/sysconfig/backup.xml \
    vendor/ancient/config/permissions/privapp-permissions-system-ancient.xml:system/etc/permissions/privapp-permissions-system-ancient.xml \
    vendor/ancient/config/permissions/privapp-permissions-product-ancient.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-product-ancient.xml \
    vendor/ancient/config/permissions/privapp-permissions-system-google-ancient.xml:system/etc/permissions/privapp-permissions-system-google-ancient.xml \
    vendor/ancient/config/permissions/privapp-permissions-product-google-ancient.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-product-google-ancient.xml \
    vendor/ancient/config/permissions/privapp-permissions-elgoog.xml:system/etc/permissions/privapp-permissions-elgoog.xml \
    vendor/ancient/config/permissions/privapp-permissions-system_ext-ancient.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/privapp-permissions-system_ext-ancient.xml

# Live Display
PRODUCT_COPY_FILES += \
    vendor/ancient/config/permissions/privapp-permissions-livedisplay.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-livedisplay.xml

# Copy all ancient-OS-specific init rc files
$(foreach f,$(wildcard vendor/ancient/prebuilt/common/etc/init/*.rc),\
    $(eval PRODUCT_COPY_FILES += $(f):system/etc/init/$(notdir $f)))

# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    vendor/ancient/prebuilt/common/lib/content-types.properties:system/lib/content-types.properties

# Enable Android Beam on all targets
PRODUCT_COPY_FILES += \
    vendor/ancient/config/permissions/android.software.nfc.beam.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.nfc.beam.xml

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl

# Power whitelist
PRODUCT_COPY_FILES += \
    vendor/ancient/config/permissions/custom-power-whitelist.xml:system/etc/sysconfig/custom-power-whitelist.xml

# Do not include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Enable ccache
USE_SYSTEM_CCACHE := true

# Charger
PRODUCT_PACKAGES += \
    charger_res_images

# Storage manager
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.storage_manager.enabled=true

# Media
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true

PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/ancient/overlay
DEVICE_PACKAGE_OVERLAYS += vendor/ancient/overlay/common

# Cutout control overlay
PRODUCT_PACKAGES += \
    NoCutoutOverlay

# Dex preopt
PRODUCT_DEXPREOPT_SPEED_APPS += \
    SystemUI \
    NexusLauncherRelease

# Branding
include vendor/ancient/config/branding.mk

# Overlays
include vendor/overlays/config.mk

# Variant
ifeq ($(ANCIENT_GAPPS), true)
# Inherit GMS, Pixel Features, and Modules.
include vendor/google/gms/config.mk
# Don't preoptimize prebuilts when building GMS.
DONT_DEXPREOPT_PREBUILTS := true
# Pixel Features
include vendor/google/pixel/config.mk
else
include vendor/ancient/config/basicapps.mk
endif

# Blur
ifeq ($(TARGET_USES_BLUR), true)
PRODUCT_PRODUCT_PROPERTIES += \
    ro.sf.blurs_are_expensive=1 \
    ro.surface_flinger.supports_background_blur=1
endif

# Customization
#include vendor/google-customization/config.mk

# Pixelstyle
include vendor/pixelstyle/config.mk

# Prebuilts
include vendor/prebuilts/config.mk

# Fonts
include vendor/ancient/prebuilt/common/fonts/fonts.mk

# Packages
include vendor/ancient/config/packages.mk

# Plugins
include packages/apps/Plugins/plugins.mk

$(call inherit-product-if-exists, external/motorola/faceunlock/config.mk)

ifeq ($(EXTRA_FOD_ANIMATIONS),true)
PRODUCT_PACKAGES += \
    FodAnimationResources
endif

-include $(WORKSPACE)/build_env/image-auto-bits.mk
