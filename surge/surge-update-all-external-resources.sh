#!/usr/bin/env zsh

# Dependency: This script requires `Surge` installed: https://nssurge.com/

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Surge Update All External Resources
# @raycast.mode silent

# Optional parameters:
# @raycast.packageName Surge
# @raycast.icon images/Surge.png

# @Documentation:
# @raycast.description Update all external resources in Surge.
# @raycast.author Sky Jia
# @raycast.authorURL https://github.com/skyjia/raycast-script-commands

# check if surge-cli is installed
if ! command -v surge-cli &> /dev/null; then
  echo "surge-cli command is required (https://manual.nssurge.com/others/cli.html).";
  exit 1;
fi

surge-cli external-resource update all
echo "All external resources have been updated."
