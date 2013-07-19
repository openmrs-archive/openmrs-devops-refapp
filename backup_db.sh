#!/bin/bash

#MYSQLUSER=bamboouser
MYSQLUSER=root
MYSQLPW=$(<shh.txt)
MYSQLSCHEMA=bamboo
#BACKUPDIR='/opt/bamboo-home/backups'
BACKUPDIR='.'
CURRENTTIME=`date +"%Y-%m-%d-%H:%M"`

checkSecret () {
  if [ ! -f shh.txt ]
    then
      echo "ERROR:  Can't find the credentials for MYSQL"
      exit
  fi
}

dumpSchema () {
  checkSecret
  if ! type mysqldump &>/dev/null;
    then
      echo 'The mysqldump command is not available.'
      exit;
    else
      mysqldump -u ${MYSQLUSER} -p${MYSQLPW} ${MYSQLSCHEMA} | gzip -9 > ${BACKUPDIR}/bamboo_db_dump-${CURRENTTIME}.sql.gz
  fi
}

dumpSchema