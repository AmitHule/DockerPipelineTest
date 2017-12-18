#!/bin/sh -e

./gradlew build
pwd
chmod 777 ../built-androiod-app
cp app/build/outputs/apk/app-debug.apk built-android-app/

