#!/bin/sh

source /home/rgddata/pipelines/pipeUtils/bin/set_env.sh

cd $(dirname $0)
OUTPUT_FOLDER=sql_output/
OUTPUT_FILE=$OUTPUT_FOLDER/QTLs_with_multiple_VT_annotations.tsv

echo "Getting a list of QTLs that are annotated to multiple VT terms."
$UTILS_HOME/bin/run_sql.sh get_multiple_VT_annotations.sql $OUTPUT_FILE

$UTILS_HOME/bin/send_qc_result $OUTPUT_FILE "[QTL qc] QTLs with multiple VT annotations."

mv $OUTPUT_FILE ../logs/QTLs_with_multiple_VT_annotations_$($UTILS_HOME/bin/get_log_date.sh).log

OUTPUT_FILE=$OUTPUT_FOLDER/QTLs_with_multiple_CMO_annotations.tsv

echo "Getting a list of QTLs that are annotated to multiple CMO terms."
$UTILS_HOME/bin/run_sql.sh get_multiple_CMO_annotations.sql $OUTPUT_FILE

$UTILS_HOME/bin/send_qc_result $OUTPUT_FILE "[QTL qc] QTLs with multiple CMO annotations."

mv $OUTPUT_FILE ../logs/QTLs_with_multiple_CMO_annotations_$($UTILS_HOME/bin/get_log_date.sh).log
