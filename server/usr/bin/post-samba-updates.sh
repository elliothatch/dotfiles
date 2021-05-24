#!/bin/bash
SLACK_WEBHOOK_URL=""
CHANGED_FILES="$(diff-dirs /srv/backup/samba/$(date -d '-1 day' +%Y-%m-%d)/fresh4less /srv/samba/fresh4less)"
ADD_COUNT=$(echo "$CHANGED_FILES" | grep -i '^[+]' | wc -l)
DELETE_COUNT=$(echo "$CHANGED_FILES" | grep -i '^[-]' | wc -l)
HEADER="Files changed in fresh4less: $ADD_COUNT added, $DELETE_COUNT deleted"

LINES_REMAINING=$(echo "$CHANGED_FILES" | wc -l)

MAX_LINES=50

if [ -n "$CHANGED_FILES" ]; then
	MESSAGES=()
	INDEX=1
	while [ $LINES_REMAINING -gt 0 ]; do
		VALUE="$(echo "$CHANGED_FILES" | sed -n "$INDEX,$(($INDEX+$MAX_LINES-1))p;")"
		MESSAGES+=( "$VALUE" )
		INDEX=$(($INDEX+$MAX_LINES))
		LINES_REMAINING=$(($LINES_REMAINING-$MAX_LINES))
	done

	echo "Sending ${#MESSAGES[@]} messages:"

        DATA='{
        	"text": "*'$HEADER'*\n```'${MESSAGES[0]}'```",
	}'
	echo $DATA
        curl -X POST -H 'Content-type: application/json' --data "$DATA" "$SLACK_WEBHOOK_URL"

	INDEX=1
	while [ $INDEX -lt ${#MESSAGES[@]} ]; do
		DATA='{
			"text": "```'${MESSAGES[$INDEX]}'```",
		}'
		INDEX=$(($INDEX+1))
		echo $DATA
		curl -X POST -H 'Content-type: application/json' --data "$DATA" "$SLACK_WEBHOOK_URL"
	done
fi

