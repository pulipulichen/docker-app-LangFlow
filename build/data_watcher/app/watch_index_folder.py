import os
import time
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler
import subprocess

# Constants
DELAY = 5  # Delay in seconds to check for further changes
WATCH_DIR = "/data_index"
TRIGGER_SCRIPT = "/app/ingest_data.sh"

class FileChangeHandler(FileSystemEventHandler):
    def __init__(self):
        self.last_change_time = None
        self.event_occurred = False

    def on_any_event(self, event):
        self.event_occurred = True
        self.last_change_time = time.time()
        print(f"Detected change in {event.src_path}")

def wait_for_stable(handler):
    print(f"Change detected. Waiting for {DELAY} seconds to check for further changes...")
    time.sleep(DELAY)
    
    if handler.event_occurred:
        print("Further changes detected. Restarting wait...")
        handler.event_occurred = False
        wait_for_stable(handler)
    else:
        print("No further changes detected. Proceeding with update.")
        subprocess.run(["bash", TRIGGER_SCRIPT])

if __name__ == "__main__":
    event_handler = FileChangeHandler()
    observer = Observer()
    observer.schedule(event_handler, WATCH_DIR, recursive=True)

    print(f"Watching for changes in {WATCH_DIR}...")
    try:
        observer.start()
        while True:
            time.sleep(1)
            if event_handler.last_change_time and time.time() - event_handler.last_change_time >= DELAY:
                wait_for_stable(event_handler)
                event_handler.last_change_time = None
    except KeyboardInterrupt:
        observer.stop()
    observer.join()
