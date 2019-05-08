#!/bin/bash

# Changelog "items" sorted in relevance order
#
#   Breaking - for a backwards-incompatible enhancement.
#   New - implemented a new feature.
#   Upgrade - for a dependency upgrade.
#   Update - for a backwards-compatible enhancement.
#   Fix - for a bug fix.
#   Build - changes to build process only.
#   Docs - changes to documentation only.

function getNumberByType() {
    case $1 in
        'Breaking:') number=0;;
        'New:') number=1;;
        'Upgrade:') number=2;;
        'Update:') number=3;;
        'Fix:') number=4;;
        'Build:') number=5;;
        'Docs:') number=6;;
        *) number=-1;;
    esac
    echo -n $number
}

function getTypeByNumber() {
    case $1 in
        0) type='Breaking';;
        1) type='New';;
        2) type='Upgrade';;
        3) type='Update';;
        4) type='Fix';;
        5) type='Build';;
        6) type='Docs';;
    esac
    echo -n $type
}

function buildChangelogBetweenTags () {
    # Parameters
    tagFrom=$1
    tagTo=$2
    if [ "$tagTo" == "" ]; then
        tagRange=""
        >&2 echo "Using commit messages of $tagFrom tag"
    else
        tagRange=".."
        >&2 echo "Using commit messages of $tagFrom..$tagTo range"
    fi

    # Initioalizacion
    OLDIFS="$IFS"
    IFS=$'\n' # bash specific
    remoteURL=$(git ls-remote --get-url)
    remoteURL=${remoteURL%".git"}
    remoteURL=$(echo $remoteURL|awk -F'@'  {'print "https://" $2'})
    tagDate=$(git log $tagTo -n 1  --simplify-by-decoration --pretty="format:%ai"|awk {'print $1'})
    commitWord="commit"
    commitList=$(git log ${tagFrom}${tagRange}${tagTo} --no-merges --pretty=format:"%h %s%n")
    changelog=()
    commitCount=0
    for commit in ${commitList}
    do
        hash=$(echo $commit|awk '{print $1}')
        type=$(echo $commit|awk '{print $2}')
        message=$(echo $commit|awk '{ print substr($0, index($0,$3)) }')
        number=$(getNumberByType $type)
        if [ $number -ge 0  ]; then
            changelog[$number]=$(echo "${changelog[$number]}* $message ([${hash}](${remoteURL}/${commitWord}/${hash}))\n")
            commitCount=$((commitCount+1))
        fi
    done
    if [ $commitCount -gt 0 ]; then
        echo -e "# $tagTo ($tagDate)\n"
        for number in $(seq 0 6)
        do
            type=$(getTypeByNumber $number)
            [ "${changelog[$number]}" ] && echo -e "## $type\n\n${changelog[$number]}" | sort
        done
    fi
    IFS="$OLDIFS"
}
currentTag=""
nextTag=""
tagList=$(git tag|tail -r)
for currentTag in $tagList
do
  [[ $nextTag == "" ]] || buildChangelogBetweenTags $currentTag $nextTag
  nextTag=$currentTag
done

if [ "$currentTag" != "" ]; then
    buildChangelogBetweenTags $currentTag
fi