#!/bin/bash -eu

export DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
#source ${DIR}/.creds
export DIR_DATE=$(date +%Y_%m_%d)
export PIC_DATE=$(date +%Y_%m_%d_%H_%M)
mkdir ${DIR}/${DIR_DATE}/ || true
fswebcam --device V4L2:/dev/video2 -D 2 -S 20 --resolution 1280x720 --frames 1 --delay 1 --no-banner --no-timestamp  --save ${DIR}/${DIR_DATE}/$PIC_DATE.jpg
cp ${DIR}/${DIR_DATE}/$PIC_DATE.jpg ${DIR}/latest.jpg
#curl http://${USER}:${PASSWORD}@${WEBCAM_PATH}  -o ${DIR}/${DIR_DATE}/${PIC_DATE}.jpg
#/home/boy/.local/bin/aws s3 cp ${DIR}/${DIR_DATE}/${PIC_DATE}.jpg s3://${BUCKET}/ --acl public-read --metadata-directive REPLACE --cache-control max-age=2592000
#/home/boy/.local/bin/aws s3 cp ${DIR}/${DIR_DATE}/${PIC_DATE}.jpg s3://${BUCKET}/latest.jpg --acl public-read

