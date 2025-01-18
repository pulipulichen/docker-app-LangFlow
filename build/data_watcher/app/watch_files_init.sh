#!/bin/bash

# =========================

# Check if inotifywait is installed
if ! command -v inotifywait &> /dev/null; then
    echo "inotifywait is not installed. Please install inotify-tools."
    exit 1
fi


# wait_time=5

# Monitor the directory for changes
inotifywait -m -r "$WATCH_DIR" --format '%w%f' -e modify -e create |
while read -r file; do
  echo "Detected change in: $file"
  
  # Start monitoring the file for no further changes
  last_modified=$(date +%s)
  
  while true; do
    sleep 1
    current_modified=$(stat -c %Y "$file" 2>/dev/null || echo "deleted")
    
    if [[ "$current_modified" == "deleted" ]]; then
      echo "File $file was deleted."
      break
    fi

    if [[ "$current_modified" -eq "$last_modified" ]]; then
      # No changes detected for $wait_time seconds
      if [[ $(($(date +%s) - last_modified)) -ge $DELAY ]]; then
        echo "File $file has not changed for $DELAY seconds."
        cat "$file"
        break
      fi
    else
      # Update the last modification time
      last_modified=$current_modified
    fi
  done
done