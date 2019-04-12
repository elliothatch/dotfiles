#!/bin/bash
SLACK_WEBHOOK_URL=""
CHANGED_FILES="$(diff-dirs /srv/backup/samba/$(date -d '-1 day' +%Y-%m-%d)/fresh4less /srv/samba/fresh4less)"
if [ -n "$CHANGED_FILES" ]; then
	DATA='{"text":">>>'$CHANGED_FILES'"}'
	echo $DATA
	curl -X POST -H 'Content-type: application/json' --data "$DATA" "$SLACK_WEBHOOK_URL"
fi
