#!/usr/bin/env bash


# `realpath` is not avariable on Mac OS
function getpath(){
  perl -MCwd -e 'print Cwd::abs_path shift' "$1"
}

APP_NAME="maoxian_web_clipper_native"
DIR=$(dirname $(getpath "$0"))

# Chrome
if [ "$(whoami)" = "root" ]; then
  TARGET_DIR="/etc/opt/chrome/native-messaging-hosts"
else
  TARGET_DIR="$HOME/.config/google-chrome/NativeMessagingHosts"
fi

# create directory
mkdir -p "$TARGET_DIR"

# copy to manifest file to target dir
cp "$DIR/manifest.json" "$TARGET_DIR/${APP_NAME}.json"

# Update host path in the manifest.
APP_PATH=$DIR/main.rb
ESCAPED_APP_PATH=${APP_PATH////\\/}
sed -i -e "s/APP_PATH/$ESCAPED_APP_PATH/" "$TARGET_DIR/$APP_NAME.json"

# set permissions
chmod o+r "$TARGET_DIR/${APP_NAME}.json"

echo "[Chrome] Native messaging host $APP_NAME has been installed."
