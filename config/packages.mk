# Config
PRODUCT_PACKAGES += \
    SimpleDeviceConfig

# CutOut
PRODUCT_PACKAGES += \
    NoCutoutOverlay1 \
    NoCutoutOverlay2

# Extra tools
PRODUCT_PACKAGES += \
    7z \
    awk \
    bash \
    bzip2 \
    curl \
    getcap \
    htop \
    lib7z \
    libsepol \
    nano \
    pigz \
    powertop \
    setcap \
    unrar \
    unzip \
    vim \
    wget \
    zip

# Filesystems tools
PRODUCT_PACKAGES += \
    fsck.exfat \
    fsck.ntfs \
    mke2fs \
    mkfs.exfat \
    mkfs.ntfs \
    mount.ntfs

# Fonts
PRODUCT_PACKAGES += \
    Ancient-Fonts

# Sqlite
PRODUCT_PACKAGES += \
    sqlite3

# Packages
PRODUCT_PACKAGES += \
    CustomDoze \
    Eleven \
    GamingMode \
    OmniStyle \
    Launcher3QuickStep \
    ThemePicker \
    TouchGestures \
    Recorder \
    SoftAPManager \
    StitchImage \
    OmniJaws \
    WeatherIcons

ifeq ($(ANCIENT_GAPPS), true)
PRODUCT_PACKAGES += \
    PixelLiveWallpaperPrebuilt
endif
