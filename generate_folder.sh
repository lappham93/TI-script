#!/bin/sh
function validate() {
  if ! [[ $1 =~ ^[0-9]{4}$ ]]
  then
    echo "Invalid year $1"
    exit
  fi
}

PROJECT=$1
YEAR=$2
validate $YEAR
BASE_FOLDER="./$PROJECT/$YEAR"
[ ! -d "$BASE_FOLDER" ] && mkdir -p $BASE_FOLDER
for (( i=1; i <= 12; i++ ))
do
  MONTH=$(printf "%02d" $i)
  for item in "01. Requirements" "02. Design" "03. Source Code" "04. Test"
  do
    itemFolder="$BASE_FOLDER/$MONTH/$item"
#     echo $itemFolder
    [ ! -d "$itemFolder" ] && mkdir -p "$itemFolder"
  done
done