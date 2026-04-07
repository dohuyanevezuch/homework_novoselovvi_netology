#!/bin/bash

DIR="/home/dohuyanevezuch"
TAR="/tmp/backup"
LOG_TAG="user_backup"

rsync -a --delete $DIR $TAR

if [ $? -eq 0 ]; then
        logger -t $LOG_TAG "Удачная синхронизация"
else
        logger -t $LOG_TAG "ОШИБКА синхронизации"
fi
