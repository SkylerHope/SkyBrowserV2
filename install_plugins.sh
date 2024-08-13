#!/bin/bash

# Function to install GStreamer plugins
install_plugins() {
  case "$1" in
    "apt-get")
      sudo apt-get update
      sudo apt-get install -y gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav
      ;;
    "dnf")
      sudo dnf install -y gstreamer1-plugins-bad-free gstreamer1-plugins-ugly gstreamer1-libav
      ;;
    "yum")
      sudo yum install -y gstreamer1-plugins-bad-free gstreamer1-plugins-ugly gstreamer1-libav
      ;;
    "zypper")
      sudo zypper install -y gstreamer-plugins-bad gstreamer-plugins-ugly gstreamer-plugins-libav
      ;;
    "pacman")
      sudo pacman -S --noconfirm gst-plugins-bad gst-plugins-ugly gst-libav
      ;;
    *)
      echo "Unsupported or unknown package manager: $1"
      exit 1
      ;;
  esac
}

# Detect the package manager
if command -v apt-get &> /dev/null; then
  PKG_MANAGER="apt-get"
elif command -v dnf &> /dev/null; then
  PKG_MANAGER="dnf"
elif command -v yum &> /dev/null; then
  PKG_MANAGER="yum"
elif command -v zypper &> /dev/null; then
  PKG_MANAGER="zypper"
elif command -v pacman &> /dev/null; then
  PKG_MANAGER="pacman"
else
  echo "No supported package manager found. Exiting."
  exit 1
fi

echo "Detected package manager: $PKG_MANAGER"

# Install the plugins using the detected package manager
install_plugins "$PKG_MANAGER"

echo "GStreamer plugins installed successfully."