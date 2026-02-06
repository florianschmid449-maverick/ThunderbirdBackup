#!/bin/bash

# ==============================================================================
# Thunderbird Profile Backup Script for Fedora
# ==============================================================================

# 1. Define Variables
# -------------------
# The default location for Thunderbird profiles on Fedora is ~/.thunderbird
SOURCE_DIR="$HOME/.thunderbird"
# Destination folder in Documents
BACKUP_DIR="$HOME/Documents/Thunderbird_Backups"
# Get current date and time for the filename (Format: YYYY-MM-DD_HH-MM-SS)
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
OUTPUT_FILE="thunderbird_profile_backup_${TIMESTAMP}.tar.gz"

# 2. Safety Checks
# ----------------
# Check if Thunderbird folder exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Thunderbird directory not found at $SOURCE_DIR"
    exit 1
fi

# Check if Thunderbird is currently running
# Backing up while running can lead to corrupted database files (places.sqlite, etc.)
if pgrep "thunderbird" > /dev/null; then
    echo "WARNING: Thunderbird is currently running."
    echo "It is highly recommended to close Thunderbird to ensure data integrity."
    read -p "Do you want to continue anyway? (y/n): " -n 1 -r
    echo    # move to a new line
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Backup cancelled."
        exit 1
    fi
fi

# 3. Create Backup Directory
# --------------------------
# mkdir -p creates the directory if it doesn't exist, and does nothing if it does
if [ ! -d "$BACKUP_DIR" ]; then
    echo "Creating backup directory: $BACKUP_DIR"
    mkdir -p "$BACKUP_DIR"
fi

# 4. Perform Backup
# -----------------
echo "Starting backup of $SOURCE_DIR..."
echo "This may take a moment depending on the size of your mail cache."

# -c: create archive
# -z: compress with gzip
# -f: filename
# -C: change directory (prevents storing the full /home/user/ path structure inside the zip)
tar -czf "$BACKUP_DIR/$OUTPUT_FILE" -C "$HOME" .thunderbird

# 5. Verify Success
# -----------------
if [ $? -eq 0 ]; then
    echo "--------------------------------------------------------"
    echo "SUCCESS: Backup created successfully!"
    echo "Location: $BACKUP_DIR/$OUTPUT_FILE"
    echo "Size: $(du -h "$BACKUP_DIR/$OUTPUT_FILE" | cut -f1)"
    echo "--------------------------------------------------------"
else
    echo "ERROR: Backup failed."
    exit 1
fi
