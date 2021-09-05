
# Boot Animation

corvus_device := $(patsubst %f,%,$(subst corvus_,,$(TARGET_PRODUCT)))

ifneq ($(filter s2 jd2019 kunlun2 begonia raphael lavender payton mido miatoll excalibur gram whyred ginkgo beryllium violet X00T surya sakura phoenix RMX1921 CPH1859 RMX2001 juice apollo vayu kebab mojito,$(corvus_device)),)
scr_resolution := 1080
endif

ifneq ($(filter ysl laurel_sprout,$(corvus_device)),)
scr_resolution := 720
endif

ifneq ($(wildcard vendor/corvus/prebuilt/common/bootanimation/$(scr_resolution).zip),)
PRODUCT_COPY_FILES += \
    vendor/corvus/prebuilt/common/bootanimation/$(scr_resolution).zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation.zip
endif

