#!/bin/sh

S3_HOST=$( printenv s3-host )
S3_REGION=$( printenv s3-region  )
S3_USER_KEY=$( printenv s3-user-key )
S3_USER_SECRET=$( printenv s3-user-secret )

if [ ! -z "$S3_REGION" ]; then
  S3_REGION="--region $S3_REGION"
else
  S3_REGION=''
fi

echo -e "\n\n=========================== PUSHING REPORTS TO S3 ================================================\n"
echo -e "S3_HOST: $S3_HOST\n"
echo -e "S3_REGION: $S3_REGION\n"
echo -e "S3_USER_KEY: $S3_USER_KEY\n"
echo -e "S3_USER_SECRET: $S3_USER_SECRET\n"

mc alias set s3 "$S3_HOST" "$S3_USER_KEY" "$S3_USER_SECRET"

mc mb s3/onboarder --ignore-existing $S3_REGION

mc cp --recursive reports s3/onboarder/

echo -e "\n\nReports pushed to minio"