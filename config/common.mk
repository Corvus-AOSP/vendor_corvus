ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

# Google Play services configuration
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent

# Additional props
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    dalvik.vm.debug.alloc=0 \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.android.dataroaming=false \
    media.recorder.show_manufacturer_and_model=true \
    ro.opa.eligible_device=true \
    drm.service.enabled=true \
    media.mediadrmservice.enable=true
    net.tethering.noprovisioning=true \
    keyguard.no_require_sim=true \
    persist.sys.disable_rescue=true \
    persist.debug.wfd.enable=1 \
    persist.sys.wfd.virtual=0 \
    ro.input.video_enabled=false

# Gapps
ifeq ($(USE_GAPPS),true)
$(call inherit-product-if-exists, vendor/google/gms/config.mk)
$(call inherit-product, vendor/google/pixel/config.mk)

PRODUCT_COPY_FILES += \
$(call find-copy-subdir-files,*,vendor/corvus/prebuilt/product/usr/,$(TARGET_COPY_OUT_PRODUCT)/usr)
endif

# StorageManager configuration
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.storage_manager.enabled=1 \
    ro.storage_manager.show_opt_in=false

# Disable writing to XML as binary.
PRODUCT_PRODUCT_PROPERTIES += \
    persist.sys.binary_xml=false

# Blurs
PRODUCT_SYSTEM_EXT_PROPERTIES += \
    ro.sf.blurs_are_expensive=1 \
    ro.surface_flinger.supports_background_blur=1
    
# Disable blur on app-launch
PRODUCT_SYSTEM_EXT_PROPERTIES += \
    ro.launcher.blur.appLaunch=0

# Disable remote keyguard animation
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    persist.wm.enable_remote_keyguard_animation=0

# IORap app launch prefetching using Perfetto traces and madvise
PRODUCT_PRODUCT_PROPERTIES += \
    ro.iorapd.enable=true

PRODUCT_SYSTEM_PROPERTIES += \
    persist.device_config.runtime_native_boot.iorap_perfetto_enable=true

# Proton Clang
ifeq ($(USE_PROTON),true)
KERNEL_SUPPORTS_LLVM_TOOLS := true
TARGET_KERNEL_CLANG_VERSION := proton
TARGET_KERNEL_CLANG_PATH := $(shell pwd)/prebuilts/clang/host/linux-x86/clang-proton
TARGET_KERNEL_CROSS_COMPILE_PREFIX := aarch64-linux-gnu-
endif

# Copy all custom init rc files
$(foreach f,$(wildcard vendor/corvus/prebuilt/common/etc/init/*.rc),\
    $(eval PRODUCT_COPY_FILES += $(f):$(TARGET_COPY_OUT_SYSTEM)/etc/init/$(notdir $f)))

# init
PRODUCT_COPY_FILES += \
    vendor/corvus/prebuilt/common/etc/init/init.corvus-system_ext.rc:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/init/init.corvus-system_ext.rc

# Permission
PRODUCT_COPY_FILES += \
    vendor/corvus/prebuilt/common/etc/permissions/corvus-power-whitelist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/corvus-power-whitelist.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/Vendor_045e_Product_0719.kl

# Backup tool
PRODUCT_COPY_FILES += \
    vendor/corvus/build/tools/backuptool.sh:install/bin/backuptool.sh \
    vendor/corvus/build/tools/backuptool.functions:install/bin/backuptool.functions \
    vendor/corvus/build/tools/50-corvus.sh:$(TARGET_COPY_OUT_SYSTEM)/addon.d/50-corvus.sh

# Disable vendor restrictions
PRODUCT_RESTRICT_VENDOR_FILES := false

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Enable ccache
USE_CCACHE := true

# Art
include vendor/corvus/config/art.mk

# Boot animation
include vendor/corvus/config/bootanimation.mk

# Branding
include vendor/corvus/config/branding.mk

# Packages
include vendor/corvus/config/packages.mk

# TouchGestures
PRODUCT_PACKAGES += \
    TouchGestures

# Themes
#include vendor/themes/common.mk

# Overlays
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/corvus/overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/corvus/overlay/common

# Copy all init rc files
$(foreach f,$(wildcard vendor/corvus/prebuilt/common/etc/init/*.rc),\
	$(eval PRODUCT_COPY_FILES += $(f):$(TARGET_COPY_OUT_SYSTEM)/etc/init/$(notdir $f)))

# Face Unlock
TARGET_FACE_UNLOCK_SUPPORTED ?= true
ifeq ($(TARGET_FACE_UNLOCK_SUPPORTED),true)
PRODUCT_PACKAGES += \
    FaceUnlockService
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.face_unlock_service.enabled=$(TARGET_FACE_UNLOCK_SUPPORTED)
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.biometrics.face.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.biometrics.face.xml
endif

# Flatten APEXs for performance
OVERRIDE_TARGET_FLATTEN_APEX := true
# This needs to be specified explicitly to override ro.apex.updatable=true from
# # prebuilt vendors, as init reads /product/build.prop after /vendor/build.prop
PRODUCT_PRODUCT_PROPERTIES += ro.apex.updatable=false

# Enable support of one-handed mode
PRODUCT_PRODUCT_PROPERTIES += \
    ro.support_one_handed_mode=true

# Enable gestural navigation overlay to match default navigation mode
PRODUCT_PRODUCT_PROPERTIES += \
    ro.boot.vendor.overlay.theme=com.android.internal.systemui.navbar.gestural;com.google.android.systemui.gxoverlay
