#!/usr/bin/env bash
# shell script to run QtlQC Pipeline
. /etc/profile

APPNAME=QtlQC
APPDIR=/home/rgddata/pipelines/$APPNAME
SERVER=`hostname -s | tr '[a-z]' '[A-Z]'`
EMAIL_LIST=mtutaj@mcw.edu
if [ "$SERVER" = "REED" ]; then
  EMAIL_LIST=mtutaj@mcw.edu,slaulede@mcw.edu
fi

cd $APPDIR

java -Dspring.config=$APPDIR/../properties/default_db.xml \
    -Dlog4j.configuration=file://$APPDIR/properties/log4j.properties \
    -jar lib/$APPNAME.jar "$@" 2>&1 | tee run.log

VT_MULTIS_FILE="logs/QTLs_with_multiple_VT_annotations_daily.log"
if [ -s "$VT_MULTIS_FILE" ]; then
    mailx -s "[$SERVER] QTL qc: QTLs with multiple VT annotations." $EMAIL_LIST < $VT_MULTIS_FILE
fi

CMO_MULTIS_FILE="logs/QTLs_with_multiple_CMO_annotations_daily.log"
if [ -s "$CMO_MULTIS_FILE" ]; then
    mailx -s "[$SERVER] QTL qc: QTLs with multiple CMO annotations." $EMAIL_LIST < $CMO_MULTIS_FILE
fi

mailx -s "[$SERVER] QtlQC pipeline OK" $EMAIL_LIST < run.log
