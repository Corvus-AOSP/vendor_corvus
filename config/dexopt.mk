# Dex pre-opt
WITH_DEXPREOPT := true
DONT_DEXPREOPT_PREBUILTS := true
WITH_DEXPREOPT_BOOT_IMG_AND_SYSTEM_SERVER_ONLY := false
PRODUCT_DEX_PREOPT_DEFAULT_COMPILER_FILTER := speed-profile

# Boot image profile
PRODUCT_USE_PROFILE_FOR_BOOT_IMAGE := true
PRODUCT_DEX_PREOPT_BOOT_IMAGE_PROFILE_LOCATION := frameworks/base/config/boot-image-profile.txt

# Speed apps
PRODUCT_DEXPREOPT_SPEED_APPS += \
  SystemUI \
  Settings \
  Launcher3QuickStep

# System server compiler
PRODUCT_SYSTEM_SERVER_COMPILER_FILTER := speed-profile

# Dexopt boot types
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    pm.dexopt.first-boot=quicken \
    pm.dexopt.boot=verify

# Dexopt filters
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    pm.dexopt.install=speed-profile \
    pm.dexopt.bg-dexopt=speed-profile \
    pm.dexopt.ab-ota=speed-profile \
    pm.dexopt.inactive=verify \
    pm.dexopt.shared=speed

# dex2oat threads (default)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    dalvik.vm.dex2oat-threads=8 \
    dalvik.vm.boot-dex2oat-threads=8