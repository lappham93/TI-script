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
PROJECT_FOLDER=$3
BRANCH=$4
validate $YEAR
BASE_FOLDER="./$PROJECT/$YEAR"
SOURCE_FOLDER="03. Source Code"
for (( i=1; i <= 12; i++ ))
do
  MONTH=$(printf "%02d" $i)
  itemFolder="$BASE_FOLDER/$MONTH/$SOURCE_FOLDER"
  if [ -f "$itemFolder/diff.patch" ] || [ -f "$itemFolder/$BRANCH/diff.patch" ]
  then
    echo "Source existed in $itemFolder"
    continue
  else
    echo "Import $itemFolder"
    FROM="$MONTH/01/$YEAR"
    [[ $MONTH = 12 ]] && TO="01/01/$(($YEAR+1))" || TO="$(printf "%02d" $((10#$MONTH+1)))/01/$YEAR"
    ~/Documents/tax/get_dif.sh -p $PROJECT_FOLDER -d "$itemFolder" -b $BRANCH -f $FROM -t $TO
  fi
done