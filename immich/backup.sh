#!/bin/bash

TIMESTAMP=$(date '+%Y-%m-%d_%H:%M')
DEST_DIR="/media/manuel/SEAGATE/immich"
SOURCE_DIR="$HOME/manuel/immich"
mkdir -p "$DEST_DIR"
tar -czvf "$SOURCE_DIR/home_backup_$TIMESTAMP.tar.gz" -C "$DEST_DIR" .
echo -e "\nBackup of $SOURCE_DIR completed at $DEST_DIR/home_backup_$TIMESTAMP.tar.gz\n"