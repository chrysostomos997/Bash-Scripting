#!/bin/bash

# Prompt the user to enter backup directories
echo "Enter the directories you want to back up (separated by spaces):"
read -r -a backup_directories

# Check if at least one directory is provided
if [ ${#backup_directories[@]} -eq 0 ]; then
    echo "No directories provided. Exiting."
    exit 1
fi

# Create a timestamp for the backup file
timestamp=$(date +"%Y%m%d_%H%M%S")

# Prompt the user to enter the destination directory
echo "Enter the destination directory for the backup:"
read -r backup_destination

# Check if the backup destination directory exists, create it if not
if [ ! -d "$backup_destination" ]; then
    mkdir -p "$backup_destination"
fi

# Create the backup archive file
backup_file="$backup_destination/backup_$timestamp.tar.gz"

# Create the backup
tar -czvf "$backup_file" "${backup_directories[@]}"

# Check if the backup was successful
if [ $? -eq 0 ]; then
    echo "Backup created successfully: $backup_file"
else
    echo "Backup failed."
fi

*/2 * * * * /home/test/backupfiles.sh

