#!/bin/bash -u
export DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
#source ${DIR}/.creds
export DIR_DATE=$(date +%Y_%m_%d --date "yesterday")
# 24 frames a second + 1 photo every minute = video is 1 minute long
ffmpeg -r:v 24 -pattern_type glob -i "${DIR}/${DIR_DATE}/*.jpg" -codec:v libx264 -preset veryslow -pix_fmt yuv420p  -crf 28  -an ${DIR}/rendered/${DIR_DATE}.mp4
ffmpeg -pattern_type glob -i "${DIR}/${DIR_DATE}/*.jpg" -filter_complex scale=120:-1,tile=41x35 ${DIR}/rendered/${DIR_DATE}_complete.jpg
gm montage -bordercolor black -tile 60x24 -borderwidth 0 ${DIR}/${DIR_DATE}/*.jpg ${DIR}/rendered/${DIR_DATE}_montage.jpg
#/home/boy/.local/bin/aws s3 cp ${DIR_DATE}_thumbnail.mp4 s3://${BUCKET}/${DIR_DATE}_thumbnail.mp4 --acl public-read --metadata-directive REPLACE --cache-control max-age=2592000
#/home/boy/.local/bin/aws s3 cp ${DIR_DATE}.mp4 s3://${BUCKET}/${DIR_DATE}.mp4 --acl public-read --metadata-directive REPLACE --cache-control max-age=2592000
#/home/boy/.local/bin/aws s3 cp ${DIR_DATE}_complete.jpg s3://${BUCKET}/${DIR_DATE}_complete.jpg --acl public-read --metadata-directive REPLACE --cache-control max-age=2592000

