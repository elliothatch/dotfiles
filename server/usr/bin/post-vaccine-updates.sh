#!/bin/bash
SLACK_WEBHOOK_URL=""
TARGET_URL="https://coronavirus.marinhhs.org/vaccine/P1Bsignup"
FILE_BASE_NAME="vaccine"
FILE_NAME="$FILE_BASE_NAME.html"

BASE_PATH="/srv/http-updates"
FILE_PATH="$BASE_PATH/$FILE_NAME"
NEW_FILE_PATH="$BASE_PATH/$FILE_BASE_NAME-new.html"

DIFF_FILE_PATH="$BASE_PATH/$FILE_BASE_NAME-diff.txt"

json_escape () {
	printf '%s' "$1" | python -c 'import json,sys; print(json.dumps(sys.stdin.read())[1:-1])'
}

mkdir -p $BASE_PATH

http $TARGET_URL --check-status > $NEW_FILE_PATH

ERR=$?
if [ $ERR -ne 0 ]; then
	DATA='{
		"text": "Error '$ERR' on page: '$TARGET_URL'",
	}'

	echo $DATA
	curl -X POST -H 'Content-type: application/json' --data "$DATA" "$SLACK_WEBHOOK_URL"

	exit 1
fi

# process file to remove lines that we expect to change and don't want to be notified for
grep -v -E "honeypot_time|form_build_id|js-view-dom-id" $NEW_FILE_PATH > "$NEW_FILE_PATH.temp"
cp "$NEW_FILE_PATH.temp" $NEW_FILE_PATH

if [ -f $FILE_PATH ]; then
	diff $FILE_PATH $NEW_FILE_PATH > $DIFF_FILE_PATH
	if [ $? -eq 1 ]; then
		DIFF="$(printf '%s' $(cat $DIFF_FILE_PATH) | python -c 'import json,sys; print(json.dumps(sys.stdin.read())[1:-1])')"

		DATA='{
			"text": "Changes detected on page: '$TARGET_URL'\n```'$DIFF'```",
		}'

		echo $DATA
		curl -X POST -H 'Content-type: application/json' --data "$DATA" "$SLACK_WEBHOOK_URL"
	fi
fi

# overwrite last file
cp $NEW_FILE_PATH $FILE_PATH

