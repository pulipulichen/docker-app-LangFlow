# Use a base image
FROM ubuntu:20.04

# Set environment variables to suppress interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install required tools including inotify-tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    inotify-tools \
    bash && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy the watch script and make it executable
COPY app/watch_files.sh /app/watch_files.sh
RUN chmod +x /app/watch_files.sh

# Expose the directory to be watched (optional)
# VOLUME /data

# Command to run the watch script
CMD ["/app/watch_files.sh"]
