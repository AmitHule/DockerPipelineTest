#!/usr/bin/env bash
pwd

APK_FILEPATH="ipa=@../built-android-app/$APK_FILENAME"
HOCKEY_REQUEST_HEADER="X-HockeyAppToken:1e830361980b49e5b92d736dd1976c2c"

response=$(curl \
  -F "status=2" \
  -F "notify=0" \
  -F "notes= test" \
  -F "notes_type=0" \
  -F "mandatory=0" \
  -F "$APK_FILEPATH" \
  -H "$HOCKEY_REQUEST_HEADER" \
https://rink.hockeyapp.net/api/2/apps/upload)

echo "Hello, world $response!"

if ! [[ "$response" == *"created_at"* ]]; then
 exit 1
fi