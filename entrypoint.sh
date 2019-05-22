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
#   Security - for security skills.
#   Deprecated - for deprecated features.

set -eo pipefail

function echo_debug () {
    if [ "$KD_DEBUG" == "1" ]; then
        echo >&2 ">>>> DEBUG >>>>> $(date "+%Y-%m-%d %H:%M:%S") $KD_NAME: $@"
    fi
}
KD_NAME="git-changelog-generator"
echo_debug "begin"

tac --version > /dev/null 2>&1 && reverseCMD="tac" || reverseCMD="tail -r"

function getNumberByType() {
    case $1 in
        'Breaking:') number=0;;
        'New:') number=1;;
        'Upgrade:') number=2;;
        'Update:') number=3;;
        'Fix:') number=4;;
        'Build:') number=5;;
        'Docs:') number=6;;
        'Security:') number=7;;
        'Deprecated:') number=8;;
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
        7) type='Security';;
        8) type='Deprecated';;
    esac
    echo -n $type
}

function buildChangelogBetweenTags () {
    local tagFrom tagTo tagRange tagName tagDate remoteURL commitWord commitList commitCount changelog commit hash type message number changelogTitle

    # Parameters
    tagFrom=$1
    tagTo=$2
    if [ "$tagTo" == "" ]; then
        tagRange=""
        tagName=$tagFrom
    else
        tagRange=".."
        tagName=$tagTo
    fi
    >&2 echo_debug ">>>> Using commit messages of $tagName"

    # Initioalizacion
    OLDIFS="$IFS"
    IFS=$'\n' # bash specific
    remoteURL=$(git ls-remote --get-url)
    remoteURL=${remoteURL%".git"}
    if [ ${remoteURL:0:3} == "git" ]; then
        remoteURL=$(echo $remoteURL|awk -F'@'  {'print "https://" $2'}|sed "s#github.com:#github.com/#g"|sed "s#gitlab.com:#gitlab.com/#g"|sed "s#bitbucket.org:#bitbucket.org/#g")
    fi
    commitWord="commit"
    commitList=$(git log ${tagFrom}${tagRange}${tagTo} --no-merges --pretty=format:"%h %s")
    commitCount=0
    changelog=()
    if [ "$tagTo" == "HEAD" ]; then
        changelogTitle="Unreleased"
    else
        tagDate=$(git log $tagName -n 1  --simplify-by-decoration --pretty="format:%ai"|awk {'print $1'})
        changelogTitle=$(echo -n "$tagName ($tagDate)")
    fi
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
        echo -e "## $changelogTitle\n"
        for number in $(seq 0 8)
        do
            type=$(getTypeByNumber $number)
            chagngelog[$number]=$(echo -e "${changelog[$number]}" | sort)
            if [ "${changelog[$number]}" ]; then
                echo -e "### $type\n\n${changelog[$number]}"
            fi
        done
    fi
    IFS="$OLDIFS"
}

echo -e "# Changelog\n"
lastTag=$(git tag | tail -n1)
if [ "$lastTag" != "" ]; then
    buildChangelogBetweenTags $lastTag HEAD
    currentTag=""
    nextTag=""
    tagList=$(git tag|$reverseCMD)
    for currentTag in $tagList
    do
        [[ $nextTag == "" ]] || buildChangelogBetweenTags $currentTag $nextTag
        nextTag=$currentTag
    done

    if [ "$currentTag" != "" ]; then
        buildChangelogBetweenTags $currentTag
    fi
fi
echo_debug "end"
