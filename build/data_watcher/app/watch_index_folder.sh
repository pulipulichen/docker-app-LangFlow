#!/bin/bash

# Delay in seconds to wait for further changes
DELAY=5

# Directory to watch
WATCH_DIR="/data_index"

# Script to execute
TRIGGER_SCRIPT="/app/ingest_data.sh"

# Function to wait for stable state
wait_for_stable() {
    echo "Change detected. Waiting for $DELAY seconds to check for further changes..."
    sleep $DELAY
    if inotifywait -r -t 1 -e modify,create,delete,move "$WATCH_DIR" &> /dev/null; then
        echo "Further changes detected. Restarting wait..."
        wait_for_stable
    else
        echo "No further changes detected. Proceeding with update."
        bash "$TRIGGER_SCRIPT"
    fi
}

# Start watching the directory
echo "Watching for changes in $WATCH_DIR..."
while inotifywait -r -e modify,create,delete,move "$WATCH_DIR"; do
    wait_for_stable
done
