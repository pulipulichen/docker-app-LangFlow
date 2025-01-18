#!/bin/bash

# Delay in seconds to wait for further changes
DELAY=1

# Directory to watch
WATCH_DIR="/data"

# =============

cd "$(dirname "$0")"
./watch_files_init.sh

# =============

last_modified_file=""

# Monitor the directory for changes
inotifywait -m -r "$WATCH_DIR" --format '%w%f' -e modify -e create |
while read -r file; do
  # Compare the variables
  if [ "$file" = "$last_modified_file" ]; then
      break
  fi

  if [[ "$file" == .* || "$file" == */.* ]]; then
    echo "Path or file name starts with '.', excluding it."
    break
  fi

  echo "Detected change in: $file"
  
  # Start monitoring the file for no further changes
  last_modified=$(date +%s)
  # echo "last_modified: $last_modified"
  
  while true; do
  
    sleep 3
    current_modified=$(stat -c %Y "$file" 2>/dev/null || echo "deleted")
    # echo $current_modified
    
    # =============

    if [[ "$current_modified" == "deleted" ]]; then
      echo "File $file was deleted."
      new_file="${file/\/data\//\/data_index\/}.md"
      if [[ -f "$new_file" ]]; then
        echo "$new_file exists. Removing it..."
        rm "$new_file"

        dir=$(dirname "$file")
        # Check if the directory exists and is empty
        if [[ -d "$dir" && -z "$(ls -A "$dir")" ]]; then
          echo "Directory $dir is empty. Removing it..."
          rmdir "$dir"
          echo "Directory $dir has been removed."
        else
          echo "Directory $dir is not empty or does not exist. No action taken."
        fi
      fi
      last_modified_file=$file
      break
    fi

    # =============

    if [[ "$current_modified" -eq "$last_modified" ]]; then
      # No changes detected for $wait_time seconds
      if [[ $(($(date +%s) - last_modified)) -ge $DELAY ]]; then
        echo "File $file has not changed for $DELAY seconds."
        # cat "$file"
        python3 file_process/main.py "$file" false
        last_modified_file=$file
        break
      fi
    else
      # Update the last modification time
      last_modified=$current_modified
    fi
  done
done