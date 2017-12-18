#!/usr/bin/env bash
pwd

APK_FILEPATH="apk=@built-android-app/$APK_FILENAME"
HOCKEY_REQUEST_HEADER="X-HockeyAppToken: $HOCKEY_APP_TOKEN"

ls ../built-android-app

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
	exit 1
fi