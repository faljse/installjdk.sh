#!/bin/sh
wget "https://github.com/adoptium/temurin21-binaries/releases/download/jdk-21.0.6%2B7/OpenJDK21U-jdk_x64_linux_hotspot_21.0.6_7.tar.gz"

mkdir -p /usr/lib/jvm

sudo tar -xvvf OpenJDK21U-jdk_x64_linux_hotspot_21.0.6_7.tar.gz -C /usr/lib/jvm/

sudo ./java-alternative.sh install /usr/lib/jvm/jdk-21.0.6+7
sudo ./java-alternative.sh set /usr/lib/jvm/jdk-21.0.6+7
sudo ./java-alternative.sh remove /usr/lib/jvm/jdk-23.0.2+7

