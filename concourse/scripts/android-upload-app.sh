#!/bin/sh -e

notes=`cat ios-repo/mechanic/notes.txt`

IPA_FILEPATH="ipa=@built-ios-app/$IPA_FILENAME"
HOCKEY_REQUEST_HEADER="X-HockeyAppToken: $HOCKEY_APP_TOKEN"

ls built-ios-app/

response=$(curl \
  -F "status=2" \
  -F "notify=1" \
  -F "notes= $notes" \
  -F "notes_type=0" \
  -F "mandatory=0" \
  -F "$IPA_FILEPATH" \
  -H "$HOCKEY_REQUEST_HEADER" \
https://rink.hockeyapp.net/api/2/apps/upload)

if ! [[ "$response" == *"created_at"* ]]; then
	exit 1
fi
