ifndef ANCIENT_BUILD_TYPE
    ANCIENT_BUILD_TYPE := Copper
endif

# Set all versions
CURRENT_DEVICE=$(shell echo "$(PRODUCT_DEVICE)" | cut -d'_' -f 2,3)
ANCIENT_DATE_YEAR := $(shell date +%Y)
ANCIENT_DATE_MONTH := $(shell date +%m)
ANCIENT_DATE_DAY := $(shell date +%d)
ANCIENT_DATE_HOUR := $(shell date +%H)
ANCIENT_DATE_MINUTE := $(shell date +%M)
#ANCIENT_BUILD_DATE_UTC := $(shell date -d '$(ANCIENT_DATE_YEAR)-$(ANCIENT_DATE_MONTH)-$(ANCIENT_DATE_DAY) $(ANCIENT_DATE_HOUR):$(ANCIENT_DATE_MINUTE) UTC' +%s)
ANCIENT_BUILD_DATE := $(ANCIENT_DATE_YEAR)$(ANCIENT_DATE_MONTH)$(ANCIENT_DATE_DAY)-$(ANCIENT_DATE_HOUR)$(ANCIENT_DATE_MINUTE)
BUILD_DATE_TIME := $(ANCIENT_DATE_YEAR)$(ANCIENT_DATE_MONTH)$(ANCIENT_DATE_DAY)-$(ANCIENT_DATE_HOUR)$(ANCIENT_DATE_MINUTE)

ANCIENT_PLATFORM_VERSION := 11.0
ANCIENT_BASE_EDITION := Society
ANCIENT_VERSION_CUSTOM := Society-v5.2
BUILD_VERSION := v5.2

ifeq ($(ANCIENT_OFFICIAL), true)
   LIST = $(shell cat vendor/ancient/ancient.devices)
   FOUND_DEVICE =  $(filter $(CURRENT_DEVICE), $(LIST))
    ifeq ($(FOUND_DEVICE),$(CURRENT_DEVICE))
      IS_OFFICIAL=true
      ANCIENT_BUILD_TYPE := Iron

# OTA
ifeq ($(ANCIENT_GAPPS), true)
include vendor/ancient/config/ota.mk
endif

    endif
    ifneq ($(IS_OFFICIAL), true)
       ANCIENT_BUILD_TYPE := Copper
       $(error Device is not official "$(FOUND)")
    endif
endif

TARGET_PRODUCT_SHORT := $(subst ancient_,,$(ANCIENT_BUILD))

ifeq ($(ANCIENT_GAPPS), true)
ANCIENT_VERSION := AncientOS-R-$(ANCIENT_BASE_EDITION)-$(BUILD_VERSION)-$(ANCIENT_BUILD)-$(ANCIENT_BUILD_TYPE)-$(ANCIENT_BUILD_DATE)-GApps
else
ANCIENT_VERSION := AncientOS-R-$(ANCIENT_BASE_EDITION)-$(BUILD_VERSION)-$(ANCIENT_BUILD)-$(ANCIENT_BUILD_TYPE)-$(ANCIENT_BUILD_DATE)-Vanilla
endif

PRODUCT_GENERIC_PROPERTIES += \
    ro.build.datetime=$(BUILD_DATE_TIME) \
    ro.ancient.custom.version=$(ANCIENT_VERSION_CUSTOM) \
    ro.ancient.version=$(ANCIENT_VERSION) \
    ro.ancient.build_date=$(ANCIENT_BUILD_DATE) \
    ro.ancient.build_type=$(ANCIENT_BUILD_TYPE) \
    ro.ancient.release_type=$(ANCIENT_BUILD_TYPE)
