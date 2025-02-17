#!/bin/bash

LOG_FILE="/my_files/backup.log"

SOURCE="$1"
DESTINATION="$2"
SIZE_THRESHOLD="$3"
REMOTE_HOST="root@172.30.2.2"

echo "$(date): Start copying..." | tee -a "$LOG_FILE"

EXCLUDED_FOLDERS=$(ssh "$REMOTE_HOST" "find '$DESTINATION' -type d -exec du -s {} + | awk '\$1 > $SIZE_THRESHOLD {print \$2}'")
if [ -n "$EXCLUDED_FOLDERS" ]; then
    echo "$(date): Oversized folders found: $EXCLUDED_FOLDERS" | tee -a "$LOG_FILE"
else
    echo "$(date): No oversized folders found." | tee -a "$LOG_FILE"
fi
EXCLUDE_OPTS="--exclude='*.log' --exclude='.*' --exclude='/target' --exclude='/logs'"

for folder in $EXCLUDED_FOLDERS; do
    EXCLUDE_OPTS+=" --exclude='$folder'"
done
RSYNC_COMMAND="rsync -av --delete $EXCLUDE_OPTS '$SOURCE' '$DESTINATION'"
echo "$(date): command executing: $RSYNC_COMMAND" | tee -a "$LOG_FILE"
eval $RSYNC_COMMAND 2>> "$LOG_FILE"

if [ "$?" -eq 0 ]; then
    echo "$(date): Backup completed successfully!" | tee -a "$LOG_FILE"

        else
    echo "$(date): Error during backup!" | tee -a "$LOG_FILE"
fi
