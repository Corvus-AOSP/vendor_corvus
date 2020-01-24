# Packages
PRODUCT_PACKAGES += \
    Corvus-Themes \
    LiveWallpapers \
    LiveWallpapersPicker \
    messaging \
    StitchImage \
    StitchImageService \
    ThemePicker \
    SystemPitchBlackOverlay \
    SystemUIPitchBlackOverlay \
    SystemDarkGrayOverlay \
    SystemUIDarkGrayOverlay \
    SystemStyleOverlay \
    SystemUIStyleOverlay \
    SystemNightOverlay \
    SystemUINightOverlay \
    CustomDoze \
    CorvusWalls \
    CustomFonts

# Charger mode images
ifeq ($(TARGET_INCLUDE_PIXEL_CHARGER),true)
PRODUCT_PACKAGES += \
    charger_res_images \
    product_charger_res_images
endif

# Filesystems tools
PRODUCT_PACKAGES += \
    fsck.exfat \
    fsck.ntfs \
    mke2fs \
    mkfs.exfat \
    mkfs.ntfs \
    mount.ntfs

# Allows registering device to Google easier for gapps
# Integrates package for easier Google Pay fixing
PRODUCT_PACKAGES += \
    sqlite3

# Config
PRODUCT_PACKAGES += \
    SimpleDeviceConfig

# Flipendo
PRODUCT_PACKAGES += \
    Flipendo

# SystemUI plugins
PRODUCT_PACKAGES += \
    QuickAccessWallet

ifneq (,$(filter $(RAVEN_LAIR), Official))
PRODUCT_PACKAGES += \
    RavenDesk
endif
