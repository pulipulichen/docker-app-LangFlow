#!/bin/bash

cd "$(dirname "$0")"

# Trigger data ingestion.
./init_process_files.sh
#./init_ingest_data.sh

# Watch data for changes.
python3 ./watch_index_folder.py &
python3 ./watch_files.py