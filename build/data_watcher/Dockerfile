# Use a base image
FROM node:23-bookworm

# Set environment variables to suppress interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install required tools including inotify-tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    inotify-tools curl \
    bash

# Set the working directory
WORKDIR /app

# Command to run the watch script
CMD ["/app/docker-entrypoint.sh"]

# Expose the directory to be watched (optional)
# VOLUME /data

# RUN apt-get update
RUN apt-get install -y python3 python3-pip
RUN apt-get install -y pipx

RUN pipx install markitdown
RUN ln -s /root/.local/pipx/venvs/markitdown/bin/markitdown /usr/bin/
RUN apt install poppler-utils -y

# Copy the watch script and make it executable
COPY app/docker-entrypoint.sh /app/docker-entrypoint.sh
RUN chmod +x /app/docker-entrypoint.sh

