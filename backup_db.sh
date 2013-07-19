#!/bin/bash

#bambooHome="/opt/bamboo-home"
bambooHome="/opt/bamboo-home"
mysqlUser=bamboouser
mysqlSchema=bamboo
backupDir='/opt/bamboo-home/backups'
currentTime=`date +"%Y-%m-%d-%H:%M"`

getSecret () {
  if [ ! -f ${bambooHome}/shh.txt ]
    then
      echo "ERROR:  Can't find the credentials for MYSQL"
      exit 1
    else
      mysqlPw=$(<${bambooHome}/shh.txt)
  fi
}

dumpSchema () {
  getSecret
  if ! type mysqldump &>/dev/null;
    then
      echo 'The mysqldump command is not available.'
      exit 1;
    else
      mysqldump -u ${mysqlUser} -p${mysqlPw} ${mysqlSchema} | gzip -9 > ${backupDir}/bamboo_db_dump-${currentTime}.sql.gz
      echo "Bamboo schema exported successfully!"
  fi
}

dumpSchema