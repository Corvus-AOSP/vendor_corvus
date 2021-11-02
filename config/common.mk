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
    ro.input.video_enabled=false \
    ro.build.selinux=1

# Gapps
ifeq ($(USE_GAPPS),true)
include vendor/google/gms/config.mk

# SetupWizard configuration
PRODUCT_PRODUCT_PROPERTIES += \
    setupwizard.feature.baseline_setupwizard_enabled=true \
    ro.opa.eligible_device=true \
    ro.setupwizard.enterprise_mode=1 \
    ro.setupwizard.esim_cid_ignore=00000001 \
    ro.setupwizard.rotation_locked=true \
    setupwizard.enable_assist_gesture_training=true \
    setupwizard.theme=glif_v3_light \
    setupwizard.feature.skip_button_use_mobile_data.carrier1839=true \
    setupwizard.feature.show_pai_screen_in_main_flow.carrier1839=false \
    setupwizard.feature.show_pixel_tos=false \
    setupwizard.feature.show_support_link_in_deferred_setup=false \
    setupwizard.feature.day_night_mode_enabled=true \
    setupwizard.feature.portal_notification=true

# Gboard configuration
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.ime.bs_theme=true \
    ro.com.google.ime.kb_pad_port_b=1 \
    ro.com.google.ime.theme_id=5 \
    ro.com.google.ime.system_lm_dir=/product/usr/share/ime/google/d3_lms
endif

# StorageManager configuration
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.storage_manager.enabled=1 \
    ro.storage_manager.show_opt_in=false

# Gboard side padding
PRODUCT_PRODUCT_PROPERTIES += \
    ro.com.google.ime.kb_pad_port_l=4 \
    ro.com.google.ime.kb_pad_port_r=4 \
    ro.com.google.ime.kb_pad_land_l=64 \
    ro.com.google.ime.kb_pad_land_r=64

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

# Permission
PRODUCT_COPY_FILES += \
    vendor/corvus/prebuilt/common/etc/permissions/corvus-power-whitelist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/corvus-power-whitelist.xml

# Backup tool
PRODUCT_COPY_FILES += \
    vendor/corvus/build/tools/backuptool.sh:install/bin/backuptool.sh \
    vendor/corvus/build/tools/backuptool.functions:install/bin/backuptool.functions \
    vendor/corvus/build/tools/50-corvus.sh:$(TARGET_COPY_OUT_SYSTEM)/addon.d/50-corvus.sh

# Permission
PRODUCT_COPY_FILES += \
    vendor/corvus/config/permissions/privapp-permissions-corvus-product.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-corvus.xml

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

# Themes
#include vendor/themes/common.mk

# Overlays
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/corvus/overlay
DEVICE_PACKAGE_OVERLAYS += vendor/corvus/overlay/common

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

# Enable support of one-handed mode
PRODUCT_PRODUCT_PROPERTIES += \
    ro.support_one_handed_mode=true

# Enable gestural navigation overlay to match default navigation mode
PRODUCT_PRODUCT_PROPERTIES += \
    ro.boot.vendor.overlay.theme=com.android.internal.systemui.navbar.gestural;com.google.android.systemui.gxoverlay
