#!/bin/bash
DIR1="$(readlink -f "$1")"
DIR2="$(readlink -f "$2")"

>&2 echo "Comparing $DIR1 to $DIR2"
diff <(find $DIR1 | sed -r "s|^.*$DIR1/?||" | sort) <(find $DIR2 | sed -r "s|^.*$DIR2/?||" | sort) | sed 's/>/Added/' | sed 's/</Deleted/'
