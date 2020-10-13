#!/bin/bash
TZ=":US/Pacific" timestamp=$(date -u)
year=$(date -d ${timestamp} "+%Y")
month=$(date -d ${timestamp} "+%m")
day=$(date -d ${timestamp} "+%e")
echo "./get-creator-answers-questions-for-arbitrary-time-period.rb $year $month $day $year $month $day"
