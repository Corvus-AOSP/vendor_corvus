# Don't build debug for host or device
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false
ART_BUILD_TARGET_NDEBUG := true
ART_BUILD_TARGET_DEBUG := false
ART_BUILD_HOST_NDEBUG := true
ART_BUILD_HOST_DEBUG := false
USE_DEX2OAT_DEBUG := false

# Speed apps
PRODUCT_DEXPREOPT_SPEED_APPS += \
  SystemUI \
  Settings \
  Launcher3QuickStep

# IORap app launch prefetching using Perfetto traces and madvise
PRODUCT_PRODUCT_PROPERTIES += \
    ro.iorapd.enable=true