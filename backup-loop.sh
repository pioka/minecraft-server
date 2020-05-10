#!/bin/sh
#screen -dr minecraft -X stuff "\r"

while :
do
  # wait
  sleep ${MC_BACKUP_PERIOD_SEC}
  
  screen -dr minecraft -X stuff "\r"
  
  # Turn off auto-save and save-all
  screen -dr minecraft -X stuff "save-off\rsave-all\r"
  sleep 1

  # create compressed archive
  tar --exclude logs --exclude backup -zcf backup/data-$(date "+%Y-%m%d-%H%M%S").tar.gz .
  if [ ! -z "${MC_BACKUP_COMPLETE_TEXT}" ]; then
    screen -dr minecraft -X stuff "tellraw @a {\"text\": \"${MC_BACKUP_COMPLETE_TEXT}\", \"color\": \"yellow\"}\r"
  fi

  # Turn on auto-save
  screen -dr minecraft -X stuff "save-on\r"
done
