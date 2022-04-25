#!/bin/bash
while getopts p:d:b:f:t: option
do
case "${option}"
in
p) projectPath=${OPTARG};;
d) storeDir=${OPTARG};;
b) branch=${OPTARG};;
f) fromDate=${OPTARG};;
t) toDate=${OPTARG};;
esac
done

if [ -z "$projectPath" ]
then
    echo "Error: Please input project path -p ..."
    exit 1
fi

if [ -z "$storeDir" ]
then
    echo "Error: Please input stored destination path -d ..."
    exit 1
fi

if [ -z "$branch" ]
then
    echo "Error: Please input target branch -b ..."
    exit 1
fi

if [ -z "$fromDate" ]
then
    echo "Error: Please input start date -f ..."
    exit 1
fi

if [ -z "$toDate" ]
then
    echo "Error: Please input end day -t ..."
    exit 1
fi
[ ! -d "$storeDir" ] && mkdir -p $storeDir
storeDir="$(cd "$(dirname "$storeDir")" && pwd -P)/$(basename "$storeDir")/$branch" # Get absoulute path
[ ! -d "$storeDir" ] && mkdir -p "$storeDir"

cd $projectPath
logResult=$(git rev-list $branch  --since $fromDate --until $toDate)

if [ -z "$logResult" ]
then
    echo "TARGET BRANCH: $branch"
    echo "FROM DATE: $fromDate"
    echo "TO DATE: $toDate"
    echo "THERE IS NO ANY MERGE COMMIT ..."
    exit 0
fi

latestCommit=$(echo "$logResult" | head -n1)
# echo "latestCommit: $latestCommit"
oldestCommit=$(echo "$logResult" | tail -n1)
# echo "oldestCommit: $oldestCommit"

currentBranch="$(git branch | awk '/\*/ {print $2}')"
temp=$(git show $oldestCommit | grep 'Merge: ' | head -n1)
IFS=' '
read -a arr <<< "$temp"
# echo "${arr[1]}"

fileList=$(git diff --name-only $latestCommit $oldestCommit)
git diff $latestCommit $oldestCommit > "$storeDir/diff.patch"
# echo "$fileList"

git checkout $latestCommit
clear
echo "Latest commit: $latestCommit"
echo "Oldest commit: $oldestCommit"
echo "PROJECT PATH: $projectPath"
echo "STORED DESTINATION PATH: $storeDir"
echo "TARGET BRANCH: $branch"
echo "FROM DATE: $fromDate"
echo "TO DATE: $toDate"
echo "Please wait 10s for fetching data..."
echo "Previous Branch: $currentBranch"
sleep 10

echo "Copied file list: "
while IFS= read -r line; do
    echo "Copying $line to $storeDir"
    dest_dir_path="$(dirname "$storeDir"/$line)"
    [ ! -d "$dest_dir_path" ] && mkdir -p "$dest_dir_path"
    abs_file_path="$(cd "$(dirname "$line")" && pwd -P)/$(basename "$line")" # Get absoulute path
    cp $abs_file_path "$dest_dir_path/$(basename "$line")"


done <<< "$fileList"
git checkout $currentBranch
