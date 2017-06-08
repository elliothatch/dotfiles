#!/bin/bash

#haha screw this garbage
#ranger execues the shell with the form /bin/sh -c set -- '$0' '$1' ...; command "$@"
#the -c syntax can cause issues so we rewrite it
# remove /bin/sh -c
#shift
#shift
#shift
#echo "termite -e '/bin/sh -c ;$@'" >> $HOME/testout.txt
#termite -e "/bin/sh -c ;\"$@\""
#echo "$@" >> $HOME/testout.txt
#shift

#echo "$@" >> $HOME/testout.txt
#ARGS=$(echo "$@" | sed "s/set -- //" | sed "s/;.*//")
#PROG=$(echo "$@" | sed "s/.*;//")
#echo "$ARGS" >> $HOME/testout.txt
#echo "$PROG" >> $HOME/testout.txt

#termite -e /bin/sh -c ;set -- $ARGS; $PROG

#shift
#PARAMS=""

#for PARAM in "$@"
#do
  #PARAMS="${PARAMS} ${PARAM}"
#done
#termite -e "${PARAMS}"

#echo "$@" > $HOME/testout.txt

shift
PARAMS=""

for PARAM in "$@"
do
  PARAMS="${PARAMS} ${PARAM}"
done
termite -e "${PARAMS}"

#ignore first two params (-e [PROG])
#PROG="$2"
#shift
#shift
#PARAMS=""

#for PARAM in "$@"
#do
  #PARAMS="${PARAMS} ${PARAM}"
#done
##echo termite -e "\"${PROG} \\\"${PARAMS}\\\"\""
##termite -e "\"${PROG} \\\"${PARAMS}\\\"\""
#termite -e "\"${PARAMS}\""

