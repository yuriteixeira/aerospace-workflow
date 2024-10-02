#!/usr/bin/env bash

# References:
# - https://nikitabobko.github.io/AeroSpace/commands#list-windows
# - https://www.alfredapp.com/help/workflows/inputs/script-filter/json/
result=$( \
  aerospace list-windows --workspace visible --format "%{app-pid} %{window-id} %{app-name} %{window-title}" | \
  while read -r appPid windowId appName windowTitle; \
  do 
    appPath="$(ps -o comm= -p "$appPid")"
    bundlePath="${appPath%%\.app*}.app"

    echo "{ 
      \"title\": \"$appName\", 
      \"subtitle\": $(echo "$windowTitle" | jq -Rsa .),
      \"match\": $(echo "$appName | $windowTitle" | jq -Rsa .),
      \"arg\": \"$windowId\", 
      \"icon\": { 
        \"type\": \"fileicon\", 
        \"path\": \"$bundlePath\" 
      } 
    },";
  done
)

echo "{ \"items\": [ $result ] }"

if [ -n "$DEBUG" ]; then
  echo ""
  echo "--- END: $(date) ---"
  echo ""
fi
