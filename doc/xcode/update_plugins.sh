#!/bin/bash

#
# Updates all plug-ins to be compatible with the latest Xcode and Xcode-beta
#

plugins_location="~/Library/Application\ Support/Developer/Shared/Xcode/Plug-ins"

# Get Xcode's version
current_xcode_version="$(defaults read /Applications/Xcode.app/Contents/Info DVTPlugInCompatibilityUUID)"

# Get Xcode-beta's version, if any
if [ -e /Applications/Xcode-beta.app ]; then
  current_xcode_beta_version="$(defaults read /Applications/Xcode-beta.app/Contents/Info DVTPlugInCompatibilityUUID)"
fi

# I haven't found a better way to get all the files in the plug-ins folder due
# to the space in the path, and my ignorance in shell scripting
for plugin in $(eval "ls $plugins_location")
do
  echo -n "Updating $plugin..."
  # Add the current Xcode's version to the array of compatible versions for
  # the plugin
  eval "defaults write $plugins_location/$plugin/Contents/Info  DVTPlugInCompatibilityUUIDs -array-add $current_xcode_version"

  # Do the same for Xcode-beta, if any
  if [ $current_xcode_beta_version ]; then
    eval "defaults write $plugins_location/$plugin/Contents/Info  DVTPlugInCompatibilityUUIDs -array-add $current_xcode_beta_version"
  fi
  echo " ✅"
done

echo -e "\nAll done 👍 \nRemember restart Xcode to see your plugins."
