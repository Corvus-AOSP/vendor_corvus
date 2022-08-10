# Custom security patch
CUSTOM_SECURITY_PATCH := 2022-08-05

# Corvus Platform Display Version
ADDITIONAL_SYSTEM_PROPERTIES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    ro.build.datetime=$(BUILD_DATE_TIME) \
    ro.corvus.build.date=$(BUILD_DATE) \
    ro.corvus.version=$(CORVUS_VERSION) \
    ro.corvus.codename=$(CORVUS_CODENAME) \
    ro.corvus.build.type=$(RAVEN_LAIR) \
    ro.corvus.build.version=$(CORVUS_VERSION_BASE) \
    ro.corvus.fingerprint=$(ROM_FINGERPRINT) \
    ro.corvus.build_security_patch=$(CUSTOM_SECURITY_PATCH)

ifneq ($(CORVUS_MAINTAINER),)
    ADDITIONAL_SYSTEM_PROPERTIES += ro.corvus.maintainer=$(CORVUS_MAINTAINER)
endif
