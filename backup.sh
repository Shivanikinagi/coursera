#!/bin/bash

# Step 1: Assign arguments
targetDirectory=$1
destinationDirectory=$2

# Step 2: Print variables
echo "Target Directory: $targetDirectory"
echo "Destination Directory: $destinationDirectory"

# Step 3: Current timestamp
currentTS=$(date +%s)

# Step 4: Backup file name
backupFileName="backup-${currentTS}.tar.gz"

# Step 5: Save current path
origAbsPath=$(pwd)

# Step 6: Go to destination directory
cd "$destinationDirectory"
destAbsPath=$(pwd)

# Step 7: Go back to original and then target directory
cd "$origAbsPath"
cd "$targetDirectory"

# Step 8: Yesterday timestamp (24 hours ago)
yesterdayTS=$((currentTS - 24*60*60))

# Step 9: Initialize array
toBackup=()

# Step 10: Loop through files
for file in *; do
    if [ -f "$file" ]; then
        fileTS=$(date -r "$file" +%s)

        # Step 11: Check if modified in last 24 hours
        if [ $fileTS -gt $yesterdayTS ]; then
            toBackup+=("$file")
        fi
    fi
done

# Step 12: Create tar archive
tar -czvf "$backupFileName" "${toBackup[@]}"

# Step 13: Move backup file
mv "$backupFileName" "$destAbsPath"