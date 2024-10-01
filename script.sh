#!/usr/bin/env bash

windowsJson=$(aerospace list-windows --workspace visible --format "{ \"title\": \"%{app-name}\", \"subtitle\": \"%{window-title}\", \"arg\": \"%{window-id}\" },")

echo "{ \"items\": [ ${windowsJson} ] }" > ./windows.json
