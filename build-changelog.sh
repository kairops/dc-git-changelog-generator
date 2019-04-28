#!/bin/bash

# Fix - for a bug fix.
# Update - for a backwards-compatible enhancement.
# Breaking - for a backwards-incompatible enhancement.
# Docs - changes to documentation only.
# Build - changes to build process only.
# New - implemented a new feature.
# Upgrade - for a dependency upgrade.

function getNumberByType() {
    case $1 in
        'Fix:') number=0;;
        'Update:') number=1;;
        'Breaking:') number=2;;
        'Docs:') number=3;;
        'Build:') number=4;;
        'New:') number=5;;
        'Upgrade:') number=6;;
    esac
    echo -n $number
}

function getTypeByNumber() {
    case $1 in
        0) type='Fix';;
        1) type='Update';;
        2) type='Breaking';;
        3) type='Docs';;
        4) type='Build';;
        5) type='New';;
        6) type='Upgrade';;
    esac
    echo -n $type
}

function buildChangelogBetweenTags () {

    # Parameters
    tagFrom=$1
    tagTo=$2

    # Initioalizacion
    OLDIFS="$IFS"
    IFS=$'\n' # bash specific
    remoteURL=$(git ls-remote --get-url)
    remoteURL=${remoteURL%".git"}
    remoteURL=$(echo $remoteURL|awk -F'@'  {'print "https://" $2'})
    tagDate=$(git log v2.6.2 -n 1  --simplify-by-decoration --pretty="format:%ai"|awk {'print $1'})
    commitWord="commit"
    commits=$(git log ${tagFrom}..${tagTo} --no-merges --pretty=format:"%h %s%n")
    changelog=()
    for commit in ${commits}
    do
        hash=$(echo $commit|awk '{print $1}')
        type=$(echo $commit|awk '{print $2}')
        message=$(echo $commit|awk '{ print substr($0, index($0,$3)) }')
        number=$(getNumberByType $type)
        changelog[$number]=$(echo "${changelog[$number]}* $message ([${hash}](${remoteURL}/${commitWord}/${hash}))\n")
    done
    echo -e "# $tagFrom ($tagDate)\n"
    for number in $(seq 1 6)
    do
        type=$(getTypeByNumber $number)
        [ "${changelog[$number]}" ] && echo -e "## $type\n\n${changelog[$number]}"
    done
    IFS="$OLDIFS"
}

buildChangelogBetweenTags v2.6.1 v2.6.2
