: << 'COMMENT'
to run script and pass args using command:

bash backup_project_script.sh root@172.30.2.2:/my_files/project_backup/ /my_files/project_backup 

COMMENT

#!/bin/bash

LOG="/my_files/backup.log"
DATE=$(date +%Y-%m-%d_%H-%M-%S)

echo "Start"
if [ $# -ne 3 ]; then
  echo "Usage: $0 <source> <destination> <size>" >&2
  echo "Example: $0 /my_files/backup root@172.30.2.2:/my_files/project_backup/ 1000" >&2
  exit 1
fi

SOURCE="${1}"
DESTINATION="${2}"
SIZE="${3}"

DEST_HOST=$(echo "${DESTINATION}" | awk -F':' '{print $1}')
DEST_PATH=$(echo "${DESTINATION}" | awk -F':' '{print $2}')

if ! [[ "${SIZE}" =~ ^[0-9]+$ ]]; then
  echo "Error: Size threshold must be a number (in KB)." >&2
  exit 1
fi

# Define refined exclude patterns
EXCLUDE="--exclude='*.log' --exclude='.*' --exclude='/big1' --exclude='/big2'"
EXCLUDE+=" --exclude='big1/copy*' --exclude='big2/copy*'"
EXCLUDE+=" --exclude='big1/uk-UA.txt' --exclude='big2/uk-UA.txt'"
EXCLUDE+=" --exclude='/logs' --exclude='/target'"
EXCLUDE+=" --exclude='/logs/*' --exclude='/target/*'"  # Ensures complete exclusion

# Find oversized directories on the remote machine
OVERSIZED=$(ssh "${DEST_HOST}" "find \"${DEST_PATH}\" -type d -exec du -ks {} + | awk -v size_threshold=\"${SIZE}\" '\$1 > size_threshold {print \$2}'")

# Add oversized directories to exclusion list
if [ -n "${OVERSIZED}" ]; then
  while IFS= read -r folder; do
    REL_PATH=$(realpath --relative-to="${DEST_PATH}" "${folder}")
    EXCLUDE="${EXCLUDE} --exclude='${REL_PATH}'"
  done <<< "${OVERSIZED}"
fi

# Construct and execute rsync command
RSYNC_CMD="rsync -avz ${EXCLUDE} \"${SOURCE}\" \"${DESTINATION}\""

echo "$DATE: Executing rsync command: ${RSYNC_CMD}" >> "${LOG}"

eval "${RSYNC_CMD}" >> "${LOG}" 2>&1

if [ $? -eq 0 ]; then
  echo "$DATE: Backup completed successfully." >> "${LOG}"
else
  echo "$DATE: Backup failed. Check $LOG for errors." >> "${LOG}"
  exit 1
fi

exit 0

