#!/usr/bin/env zsh

# Dependency: This script requires `Surge` installed: https://nssurge.com/

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Surge Add Proxy Rule
# @raycast.mode silent
# @raycast.argument1 { "type": "dropdown", "placeholder": "Domain/Process", "data": [{"title": "Domain", "value": "DOMAIN-SUFFIX"}, {"title": "Process", "value": "PROCESS-NAME"}]  }
# @raycast.argument2 { "type": "text", "placeholder": "domain name / process name" }

# Optional parameters:
# @raycast.packageName Surge
# @raycast.icon images/Surge.png

# @Documentation:
# @raycast.description Add a new proxy rule in Surge.
# @raycast.author Sky Jia
# @raycast.authorURL https://github.com/skyjia/raycast-script-commands


# if ! command -v surge-cli &> /dev/null; then
#   echo "surge-cli command is required (https://manual.nssurge.com/others/cli.html).";
#   exit 1;
# fi

# check proxy file if exists
proxy_file="$HOME/Library/Mobile Documents/iCloud~com~nssurge~inc/Documents/Profiles/rule-set/proxy.txt"
if [ ! -f "$proxy_file" ]; then
  echo "Proxy file not found: $proxy_file";
  exit 1;
fi

# check if surge-cli is installed
if ! command -v surge-cli &> /dev/null; then
  echo "surge-cli command is required (https://manual.nssurge.com/others/cli.html).";
  exit 1;
fi

# proxy rule
proxy_rule="$1,$2"


tmp_file=$(mktemp /tmp/surge-add-proxy-rule.XXXXXX) || exit 1
cat "$proxy_file" > "$tmp_file"
echo "$proxy_rule" >> "$tmp_file"
sort -u "$tmp_file" -o "$tmp_file"
mv "$tmp_file" "$proxy_file"

# reload profile
surge-cli reload

echo "Added a new proxy rule: $proxy_rule"
