# Corvus Platform Display Version
ADDITIONAL_SYSTEM_PROPERTIES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    ro.build.datetime=$(BUILD_DATE_TIME) \
    ro.corvus.build.date=$(BUILD_DATE) \
    ro.corvus.version=$(CORVUS_VERSION) \
    ro.corvus.codename=$(CORVUS_CODENAME) \
    ro.corvus.build.type=$(RAVEN_LAIR) \
    ro.corvus.build.version=$(CORVUS_VERSION_BASE) \
    ro.corvus.fingerprint=$(ROM_FINGERPRINT)

ifneq ($(CORVUS_MAINTAINER),)
    ADDITIONAL_SYSTEM_PROPERTIES += ro.corvus.maintainer=$(CORVUS_MAINTAINER)
endif
