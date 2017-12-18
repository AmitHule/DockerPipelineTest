#!/usr/bin/env bash
pwd

APK_FILEPATH="ipa=@../built-android-app/$APK_FILENAME"
HOCKEY_REQUEST_HEADER="X-HockeyAppToken: $HOCKEY_APP_TOKEN"

response=$(curl \
  -F "status=2" \
  -F "notify=0" \
  -F "notes= test" \
  -F "notes_type=0" \
  -F "mandatory=0" \
  -F "$APK_FILEPATH" \
  -H "$HOCKEY_REQUEST_HEADER" \
https://rink.hockeyapp.net/api/2/apps/upload)

if ! [[ "$response" == *"created_at"* ]]; then
- debug:
    msg: "Responseeeeeeeee {{ response }} "

	exit 1
fi