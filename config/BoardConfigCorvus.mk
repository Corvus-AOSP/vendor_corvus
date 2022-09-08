include vendor/corvus/config/BoardConfigKernel.mk
include vendor/corvus/config/BoardConfigSoong.mk

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/corvus/config/BoardConfigQcom.mk
endif

# Namespace for fwk-detect
TARGET_FWK_DETECT_PATH ?= hardware/qcom-caf/common
PRODUCT_SOONG_NAMESPACES += \
    $(TARGET_FWK_DETECT_PATH)/fwk-detect
