#!/usr/bin/env bash

DATE_STAMP=$(date '+%Y-%m-%d')

gcloud auth activate-service-account --key-file=${GOOGLE_APPLICATION_CREDENTIALS}

#SRC_DIR=/data/source
#DST_BUCKET=dest-bucket

LOG_FILE1=/tmp/${DST_BUCKET}.log

gsutil -m rsync -r ${SRC_DIR} gs://${DST_BUCKET} 2>&1 | tee ${LOG_FILE1}
