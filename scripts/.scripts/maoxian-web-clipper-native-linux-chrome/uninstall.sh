#!/usr/bin/env bash

APP_NAME="maoxian_web_clipper_native"

if [ "$(whoami)" = "root" ]; then
  TARGET_DIR="/etc/opt/chrome/native-messaging-hosts"
else
  TARGET_DIR="$HOME/.config/google-chrome/NativeMessagingHosts"
fi

rm "$TARGET_DIR/${APP_NAME}.json"
echo "Native messaging host $APP_NAME has been uninstalled."
