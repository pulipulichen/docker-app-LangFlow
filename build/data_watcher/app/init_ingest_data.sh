#!/bin/bash

SCRIPT="/app/ingest_data.sh"

# =========================

URL="http://langflow:$LANGFLOW_PORT/"

# echo "等待 $URL 可連線..."

# 等待連線成功
while ! curl -s --head --request GET "$URL" | grep "200 OK" > /dev/null; do
#   echo "正在檢查連線狀態... $URL"
  sleep 5 # 等待 2 秒後重試
done

sleep 10

# ===========================

if find /data -type f \( -name "*.md" -o -name "*.txt" -o -name "*.csv" \) | grep -q .; then
  echo "Trigger data ingestion of Langflow..."
  bash "$SCRIPT"
else
  echo "No .md files found."
fi
