# Set all versions
RAVEN_LAIR := Unofficial
CORVUS_VERSION_BASE := S4.0
CORVUS_CODENAME := Leviathan

ifneq ($(filter Trishiraj victor10520 KSSRAO ManavjitSingh MAdMiZ Fosslover Meghthedev PAiN Roxor-007 H3M3L AnhTran Sukeerat EinarG Ankan005 Ajit YadavMohit19 Ritzzz TheSanty CoolDude6942,$(CORVUS_MAINTAINER)),)
RAVEN_LAIR := Official
endif

# Set all versions
BUILD_DATE := $(shell date -u +%d-%m-%Y)
BUILD_TIME := $(shell date -u +%H%M)
BUILD_DATE_TIME := $(BUILD_TIME)$(BUILD_DATE)
ROM_FINGERPRINT := Corvus/$(RAVEN_LAIR)/$(PLATFORM_VERSION)/$(BUILD_ID)/$(shell date -u +%d%m)/$(BUILD_TIME)

ifeq ($(USE_GAPPS), true)
    CORVUS_VERSION := Corvus_v$(CORVUS_VERSION_BASE)-$(CORVUS_CODENAME)-$(CORVUS_BUILD)-Gapps-$(RAVEN_LAIR)-$(BUILD_TIME)
else
    CORVUS_VERSION := Corvus_v$(CORVUS_VERSION_BASE)-$(CORVUS_CODENAME)-$(CORVUS_BUILD)-$(RAVEN_LAIR)-$(BUILD_TIME)
endif
