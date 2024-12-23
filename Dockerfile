# Base image for Jellyfin
FROM linuxserver/jellyfin:10.10.3

# Install dependencies for building MPP
RUN apt-get update && apt-get install -y \
    build-essential cmake git libdrm-dev dh-exec dpkg-dev debhelper clinfo wget && \
    apt-get clean

# Clone the MPP repository and build Debian packages
RUN git clone https://github.com/rockchip-linux/mpp.git /tmp/mpp && \
    cd /tmp/mpp && \
    DEB_BUILD_OPTIONS="parallel=$(nproc) nocheck" dpkg-buildpackage -b -us -uc -aarm64 && \
    cd /tmp && \
    wget https://github.com/tsukumijima/libmali-rockchip/releases/download/v1.9-1-55611b0/libmali-valhall-g610-g13p0-gbm_1.9-1_arm64.deb && \
    dpkg -i *.deb && \
    ldconfig && \
    rm -rf /tmp/mpp /tmp/*.deb

# Ensure necessary devices are accessible
VOLUME ["/dev/dri", "/dev/dma_heap", "/dev/mali0", "/dev/rga"]

# Expose ports (if needed)
EXPOSE 8096 7359/udp 8920
