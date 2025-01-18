#!/bin/bash

# Base directory to search
BASE_DIR="/data"

# Loop through all files in the directory and its subdirectories
find "$BASE_DIR" -type f | while read -r file; do
    if [[ "$file" == .* || "$file" == */.* ]]; then
      echo "Path or file name starts with '.', excluding it."
      break
    fi
    # Run the Python script with the file as an argument
    python3 /app/file_process/main.py "$file" true
done
