
# Boot Animation

corvus_device := $(patsubst %f,%,$(subst corvus_,,$(TARGET_PRODUCT)))

ifneq ($(filter jd2019 kunlun2 begonia raphael enchilada lavender payton mido miatoll excalibur gram wayne whyred platina ginkgo vince tulip beryllium violet X00T X01BD RMX1801 tissot x2 jasmine_sprout sirius surya sakura grus kenzo davinci phoenix RMX1921 CPH1859 RMX2001 juice apollo,$(corvus_device)),)
scr_resolution := 1080
endif

ifneq ($(filter ysl riva land santoni X00P laurel_sprout,$(corvus_device)),)
scr_resolution := 720
endif

ifneq ($(wildcard vendor/corvus/prebuilt/common/bootanimation/$(scr_resolution).zip),)
PRODUCT_COPY_FILES += \
    vendor/corvus/prebuilt/common/bootanimation/$(scr_resolution).zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation.zip
endif

