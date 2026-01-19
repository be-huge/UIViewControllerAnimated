export THEOS_DEVICE_IP = localhost
export THEOS_DEVICE_PORT = 2222
INSTALL_TARGET_PROCESSES = SpringBoard

ifeq ($(THEOS_PACKAGE_SCHEME), rootless)
TARGET = iphone:clang:latest:15.0
else
TARGET = iphone:clang:latest:14.0
endif

ARCHS = arm64 arm64e
DEBUG = 0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ViewControllerAnimated

$(TWEAK_NAME)_FILES = $(shell find Sources/$(TWEAK_NAME) -name '*.swift') \
$(shell find Sources/$(TWEAK_NAME)C -name '*.m' -o -name '*.c' -o -name '*.mm' -o -name '*.cpp')

$(TWEAK_NAME)_SWIFTFLAGS = -ISources/$(TWEAK_NAME)C/include
$(TWEAK_NAME)_CFLAGS = -fobjc-arc -ISources/$(TWEAK_NAME)C/include

include $(THEOS_MAKE_PATH)/tweak.mk
