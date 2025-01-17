#!/bin/bash

# Paths to check and mount
# TARGET_DIR="/var/www/html/data/admin/files/data"
# SOURCE_DIR="/data"

# # Check if $TARGET_DIR exists
# if [ -e "$TARGET_DIR" ]; then
#     echo "$TARGET_DIR exists. Removing it..."
#     rm -rf "$TARGET_DIR"
#     if [ $? -eq 0 ]; then
#         echo "Successfully removed $TARGET_DIR."
#     else
#         echo "Failed to remove $TARGET_DIR. Exiting."
#         exit 1
#     fi
# fi

# # Create a symbolic link
# ln -s "$SOURCE_DIR" "$TARGET_DIR"
# if [ $? -eq 0 ]; then
#     echo "Successfully created symbolic link from $SOURCE_DIR to $TARGET_DIR."
# else
#     echo "Failed to create symbolic link. Exiting."
# fi

# ls /var/www/html/

# echo "================="

# php /var/www/html/occ files_external:create "data" local null::null -c datadir=/data
/var/www/html/occ app:enable files_external
/var/www/html/occ files_external:create "data" local null::null -c datadir=/data