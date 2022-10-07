#!/bin/sh
# rtb: Read the bible the Word of God from your terminal
# License: Public domain

SELF="$0"

get_data() {
    sed '1,/^#EOF$/d' < "$SELF" | tar xzf - -O "$1"
}

get_vers() {
    sed '1,/^#EOF$/d' < "$SELF" | tar tzf - | grep tsv | sed -e 's#bible/##' -e 's/\.tsv//'
}

get_bible() {
    # get a version from available bibles.
    sed '1,/^#EOF$/d' < "$SELF" | tar xzf - -O bible/"$1".tsv
}

if [ -z "$PAGER" ]; then
    if command -v less >/dev/null; then
	PAGER="less"
    else
	PAGER="cat"
    fi
fi

# Selects bible version to use
if [ -z "${BIBLE_VERSION}" ]; then
    # Default bible version
    bible="rvr60"
else
    bible="${BIBLE_VERSION}"
fi

show_help() {
    exec >&2
    echo "usage: $(basename "$0") [flags] [reference...]"
    echo
    echo "  -v      list versions"
    echo "  -l      list books"
    echo "  -W      no line wrap"
    echo "  -h      show help"
    echo
    echo "  Bible versions:"
    echo "      The environment variable BIBLE_VERSION is used to define"
    echo "      the bible version to use. Default version is: $bible"
    echo "      ex: export BIBLE_VERSION=rvr60"
    echo
    echo "  Reference types:"
    echo "      <Book>"
    echo "          Individual book"
    echo "      <Book>:<Chapter>"
    echo "          Individual chapter of a book"
    echo "      <Book>:<Chapter>:<Verse>[,<Verse>]..."
    echo "          Individual verse(s) of a specific chapter of a book"
    echo "      <Book>:<Chapter>-<Chapter>"
    echo "          Range of chapters in a book"
    echo "      <Book>:<Chapter>:<Verse>-<Verse>"
    echo "          Range of verses in a book chapter"
    echo "      <Book>:<Chapter>:<Verse>-<Chapter>:<Verse>"
    echo "          Range of chapters and verses in a book"
    echo
    echo "      /<Search>"
    echo "          All verses that match a pattern"
    echo "      <Book>/<Search>"
    echo "          All verses in a book that match a pattern"
    echo "      <Book>:<Chapter>/<Search>"
    echo "          All verses in a chapter of a book that match a pattern"
    exit 2
}


while [ $# -gt 0 ]; do
    isFlag=0
    firstChar="${1%"${1#?}"}"
    if [ "$firstChar" = "-" ]; then
	isFlag=1
    fi

    if [ "$1" = "--" ]; then
	shift
	break
    elif [ "$1" = "-v" ]; then
	# List all bible version available
	get_vers
	exit
    elif [ "$1" = "-l" ]; then
	# List all book names with their abbreviations
	get_bible $bible | awk -v cmd=list "$(get_data process.awk)"
	exit
    elif [ "$1" = "-W" ]; then
	export KJV_NOLINEWRAP=1
	shift
    elif [ "$1" = "-h" ] || [ "$isFlag" -eq 1 ]; then
	show_help
    else
	break
    fi
done

cols=$(tput cols 2>/dev/null)
if [ $? -eq 0 ]; then
    export KJV_MAX_WIDTH="$cols"
fi

if [ $# -eq 0 ]; then
    if [ ! -t 0 ]; then
	show_help
    fi

    # Interactive mode
    while true; do
	printf "kjv> "
	if ! read -r ref; then
	    break
	fi
	get_bible $bible | awk -v cmd=ref -v ref="$ref" "$(get_data process.awk)" | ${PAGER}
    done
    exit 0
fi

get_bible $bible | awk -v cmd=ref -v ref="$*" "$(get_data process.awk)" | ${PAGER}
