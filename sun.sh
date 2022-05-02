#!/bin/bash
PIC_DATE=$(date +%Y_%m_%d)
RISETIME=$(curl -s "http://api.sunrise-sunset.org/json?lat=54.9389106&lng=-1.6340759&formatted=0" | jq .results.sunrise | tr -d '"' )
SETTIME=$(curl -s "http://api.sunrise-sunset.org/json?lat=54.9389106&lng=-1.6340759&formatted=0" | jq .results.sunset | tr -d '"' )
echo $SETTIME
startdate=$(date --date="${RISETIME}" "+%s")
enddate=$(date --date="${SETTIME}" "+%s")
echo $startdate
echo $enddate

# date -d '@1651088372' "+%s"
#loop over all dates
current=$startdate
while (( "$current" < "$enddate" ))
do
    current=$(($current+300))
    echo $(date -d "@$current" "+%Y_%m_%d_%H_%S")
    echo $current
    echo ""

done
