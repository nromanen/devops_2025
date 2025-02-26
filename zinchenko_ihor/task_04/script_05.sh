#!/bin/bash

# Check if exactly two arguments are provided:
#   1) Remote source folder (on the second machine)
#   2) Local destination folder (on the first machine)
if [ $# -ne 2 ]; then
    echo "Usage: $0 <remote_source_folder> <local_destination_folder>"
    exit 1
fi

# Assign arguments to variables
REMOTE_SOURCE=$1
LOCAL_DEST=$2

# Check if the local destination folder exists; if not, create it.
if [ ! -d "$LOCAL_DEST" ]; then
    echo "Local destination folder $LOCAL_DEST does not exist. Creating it..."
    mkdir -p "$LOCAL_DEST"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to create local destination folder."
        exit 1
    fi
fi

# Perform the backup from the remote machine to the local destination using rsync.
rsync -av --exclude='*.log' --delete root@172.30.2.2:"${REMOTE_SOURCE}/" "${LOCAL_DEST}/"

# Check if the rsync command was successful.
if [ $? -eq 0 ]; then
    echo "Backup completed successfully from remote ${REMOTE_SOURCE} to local ${LOCAL_DEST}."
else
    echo "Error during backup."
    exit 1
fi
