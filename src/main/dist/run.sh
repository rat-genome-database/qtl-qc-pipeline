#!/usr/bin/env bash
# shell script to run QtlQC Pipeline
. /etc/profile

APPNAME=QtlQC
APPDIR=/home/rgddata/pipelines/$APPNAME
SERVER=`hostname -s | tr '[a-z]' '[A-Z]'`
EMAIL_LIST=mtutaj@mcw.edu
if [ "$SERVER" = "REED" ]; then
  EMAIL_LIST=mtutaj@mcw.edu
fi

cd $APPDIR

java -Dspring.config=$APPDIR/../properties/default_db.xml \
    -Dlog4j.configuration=file://$APPDIR/properties/log4j.properties \
    -jar lib/$APPNAME.jar "$@" 2>&1 | tee run.log

mailx -s "[$SERVER] QtlQC pipeline OK" $EMAIL_LIST < run.log
