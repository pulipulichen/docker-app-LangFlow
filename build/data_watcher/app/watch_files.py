import os
import time
import subprocess
import pathlib
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler
from file_process.main import display_file_content 

# Constants
DELAY = 1  # Delay in seconds to wait for further changes
WATCH_DIR = "/data"

class FileChangeHandler(FileSystemEventHandler):
    def __init__(self):
        self.last_modified_file = None

    def on_modified(self, event):
        self.handle_event(event)

    def on_created(self, event):
        self.handle_event(event)

    def handle_event(self, event):
        file_path = event.src_path
        if file_path == self.last_modified_file:
            return

        if os.path.isfile(file_path) is False:
            return

        if file_path.startswith('.') or os.path.basename(file_path).startswith('.'):
            print(f"Path or file name starts with '.', excluding it.")
            return

        print(f"Detected change in: {file_path}")
        last_modified_time = time.time()

        while True:
            time.sleep(3)
            try:
                current_modified_time = os.path.getmtime(file_path)
            except FileNotFoundError:
                print(f"File {file_path} was deleted.")
                new_file = file_path.replace("/data/", "/data_index/") + ".md"
                if os.path.exists(new_file):
                    print(f"{new_file} exists. Removing it...")
                    os.remove(new_file)

                    dir_path = os.path.dirname(file_path)
                    if os.path.exists(dir_path) and not os.listdir(dir_path):
                        print(f"Directory {dir_path} is empty. Removing it...")
                        os.rmdir(dir_path)
                        print(f"Directory {dir_path} has been removed.")
                    else:
                        print(f"Directory {dir_path} is not empty or does not exist. No action taken.")
                self.last_modified_file = file_path
                break

            if current_modified_time == last_modified_time:
                if time.time() - last_modified_time >= DELAY:
                    print(f"File {file_path} has not changed for {DELAY} seconds.")
                    # subprocess.run(["python3", "file_process/main.py", file_path, "false"])
                    display_file_content(file_path, False)
                    self.last_modified_file = file_path
                    break
            else:
                last_modified_time = current_modified_time

if __name__ == "__main__":
    # Ensure the current working directory is set correctly
    # os.chdir(os.path.dirname(os.path.abspath(__file__)))
    # subprocess.run(["./watch_files_init.sh"])

    # Set up watchdog observer
    event_handler = FileChangeHandler()
    observer = Observer()
    observer.schedule(event_handler, WATCH_DIR, recursive=True)
    
    print(f"Watching directory: {WATCH_DIR}")
    try:
        observer.start()
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()
    observer.join()
