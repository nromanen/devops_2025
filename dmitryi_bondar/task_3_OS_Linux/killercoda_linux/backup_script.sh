: << 'COMMENT'
to run script and pass arg using command
bash ./backup_script.sh root@172.30.2.2:/my_files/for_backup/ /my_files/file_log1/

COMMENT


#!/bin/bash

echo "Start"
SOURCE=$1
DESTINATION=$2
rsync -av --exclude '*.log' --recursive  --delete ${SOURCE} ${DESTINATION}
