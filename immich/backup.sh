#!/bin/bash

# Backup script with configurable source and destination

# Displays usage instructions, parameter descriptions, and example commands for the backup script, then exits.
#
# Outputs:
#
# * Prints usage information, parameter details, and example invocations to STDOUT.
#
# Returns:
#
# * Exits the script with status 1 after displaying help.
#
# Example:
#
#   show_help
show_help() {
    echo "Usage: $(basename "$0") <source_directory> <destination_directory> [backup_name]"
    echo ""
    echo "Parameters:"
    echo "  source_directory      Directory to backup"
    echo "  destination_directory Directory where to store the backup"
    echo "  backup_name          Optional: Custom name for the backup (default: backup)"
    echo ""
    echo "Example:"
    echo "  $(basename "$0") /home/user/documents /media/backup"
    echo "  $(basename "$0") /home/user/immich /media/backup immich_backup"
    exit 1
}

# Check if help is requested
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    show_help
fi

# Check if minimum required parameters are provided
if [[ $# -lt 2 ]]; then
    echo "Error: Missing required parameters"
    echo ""
    show_help
fi

# Assign parameters
SOURCE_DIR="$1"
DEST_DIR="$2"
BACKUP_NAME="${3:-backup}"

# Validate source directory exists
if [[ ! -d "$SOURCE_DIR" ]]; then
    echo "Error: Source directory '$SOURCE_DIR' does not exist"
    exit 1
fi

# Create destination directory if it doesn't exist
if ! mkdir -p "$DEST_DIR"; then
    echo "Error: Cannot create destination directory '$DEST_DIR'"
    exit 1
fi

# Generate timestamp
TIMESTAMP=$(date '+%d-%m-%Y')

# Create backup filename
BACKUP_FILE="${DEST_DIR}/${BACKUP_NAME}_${TIMESTAMP}.tar.gz"

echo "Starting backup..."
echo "Source: $SOURCE_DIR"
echo "Destination: $BACKUP_FILE"
echo ""

# Create the backup
if tar -czvf "$BACKUP_FILE" -C "$(dirname "$SOURCE_DIR")" "$(basename "$SOURCE_DIR")"; then
    echo ""
    echo "Backup completed successfully!"
    echo "Backup saved to: $BACKUP_FILE"
    
    # Display backup size
    BACKUP_SIZE=$(du -h "$BACKUP_FILE" | cut -f1)
    echo "Backup size: $BACKUP_SIZE"
else
    echo ""
    echo "Backup failed!"
    exit 1
fi