#!/usr/bin/env bash

# References:
# - https://nikitabobko.github.io/AeroSpace/commands#list-windows
# - https://www.alfredapp.com/help/workflows/inputs/script-filter/json/
result=$( \
  aerospace list-windows --workspace visible --format "%{app-pid} %{window-id} %{app-name}" | \
  while read -r pid id name; \
  do 
    path="$(ps -o comm= -p "$pid")"
    bundlePath="${path%%\.app*}.app"

    echo "{ 
      \"title\": \"$name\", 
      \"arg\": \"$id\", 
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
