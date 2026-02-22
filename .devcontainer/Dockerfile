FROM docker.io/zmkfirmware/zmk-dev-arm:4.1-branch

RUN apt update && apt install -y sudo

RUN echo "ubuntu ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/ubuntu \
    && chmod 0440 /etc/sudoers.d/ubuntu

RUN mkdir -p /commandhistory \
    /workspaces/zmk-config/zmk \
    /workspaces/zmk-config/zephyr \
    /workspaces/zmk-config/modules \
    /workspaces/zmk-config/tools \
    /workspaces/zmk-config/bootloader \
    /workspaces/zmk-config/forager-zmk-module \
    /workspaces/zmk-config/zmk-rgbled-widget \
    /workspaces/zmk-config/optional \
    && chown -R ubuntu:ubuntu /commandhistory /workspaces/zmk-config

WORKDIR /workspaces/zmk-config
