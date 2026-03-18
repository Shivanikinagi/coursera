#!/bin/bash

targetDirectory=$1
destinationDirectory=$2

echo "Target Directory: $targetDirectory"
echo "Destination Directory: $destinationDirectory"

currentTS=$(date +%s)

backupFileName="backup-${currentTS}.tar.gz"

origAbsPath=$(pwd)

cd "$destinationDirectory"
destAbsPath=$(pwd)

cd "$origAbsPath"
cd "$targetDirectory"

yesterdayTS=$(($currentTS - 24 * 60 * 60))

toBackup=()

for file in *; do
  if [ -f "$file" ]; then
    fileTS=$(date -r "$file" +%s)
    if [ $fileTS -gt $yesterdayTS ]; then
      toBackup+=("$file")
    fi
  fi
done

tar -czvf "$backupFileName" "${toBackup[@]}"

mv "$backupFileName" "$destAbsPath"
