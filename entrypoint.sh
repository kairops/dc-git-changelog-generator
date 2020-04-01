#!/bin/bash

# TODO: Invert "tagFrom" => "tagTo" with "tagTo" => "tagFrom" starting with HEAD
#       (simplicity of app)

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

# Check if an array contains a string
# https://stackoverflow.com/questions/3685970/check-if-a-bash-array-contains-a-value
function contains() {
    local n=$#
    local value=${!n}
    for ((i=1;i < $#;i++)) {
        if [ "${!i}" == "${value}" ]; then
            echo "y"
            return 0
        fi
    }
    echo "n"
    return 1
}

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
        *) number=9;;
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
        9) type='Misc';;
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
    remoteURL="https://$(git ls-remote --get-url|sed 's|.*//||; s|.*@||')"
    remoteURL=${remoteURL%".git"}
    commitWord="commit"
    commitList=$(git log ${tagFrom}${tagRange}${tagTo} --no-merges --pretty=format:"%h %s")
    commitCount=0
    changelog=()
    authorList=()
    changelogTitle=""
    if [ "$unreleaseFlag" == false ]; then
        if [ "$tagTo" == "HEAD" ] || [ "$tagTo" == "" ]; then
            changelogTitle="Unreleased"
            unreleaseFlag=true
        fi
    fi
    if [ "$changelogTitle" == "" ]; then
        tagDate=$(git log $tagName -n 1  --simplify-by-decoration --pretty="format:%ai"|awk {'print $1'})
        changelogTitle=$(echo -n "$tagName ($tagDate)")
    fi
    for commit in ${commitList}
    do
        hash=$(echo $commit|awk '{print $1}')
        type=$(echo $commit|awk '{print $2}')
        author=$(git log -n1 $hash --pretty="format:%aN")
        message=$(echo $commit|awk '{ print substr($0, index($0,$3)) }')
        number=$(getNumberByType $type)
        if [ $number -ge 0  ]; then
            if [ $(contains "${authorList[@]}" "$author") == "n" ] && ! [[ $author == Jenkins* ]]; then
                authorList+=("$author")
            fi
            if [ $number -eq 9 ]; then
                message=$(echo $commit|awk '{ print substr($0, index($0,$2)) }')
            fi
            changelog[$number]=$(echo "${changelog[$number]}* $message ([${hash}](${remoteURL}/${commitWord}/${hash}))\n")
            commitCount=$((commitCount+1))
        fi
    done
    if [ $commitCount -gt 0 ]; then
        echo -e "## $changelogTitle\n"
        echo -e "### Changes\n"
        for number in $(seq 0 9)
        do
            type=$(getTypeByNumber $number)
            chagngelog[$number]=$(echo -e "${changelog[$number]}" | sort)
            if [ "${changelog[$number]}" ]; then
                echo -e "#### $type\n\n${changelog[$number]}"
            fi
        done
        echo -e "### Authors\n"
        printf '* %s\n' "${authorList[@]}"
        echo
    fi
    IFS="$OLDIFS"
}

echo -e "# Changelog\n"
lastTag=$(git describe --tags $(git rev-list --tags --max-count=1) 2> /dev/null || true)
unreleaseFlag=false
buildChangelogBetweenTags $lastTag HEAD
currentTag=""
nextTag=""
tagList=$(git tag | tail -r | xargs -I@ git log --format=format:"%ai @%n" -1 @ | awk '{print $4}')
for currentTag in $tagList
do
    [[ $nextTag == "" ]] || buildChangelogBetweenTags $currentTag $nextTag
    nextTag=$currentTag
done

# First release
if [ "$currentTag" != "" ]; then
    buildChangelogBetweenTags $currentTag
fi
echo_debug "end"
