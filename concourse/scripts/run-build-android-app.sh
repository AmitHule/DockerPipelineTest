#!/bin/sh -e

./gradlew build
pwd
cp ./android-repo/app/build/outputs/apk/app-debug.apk built-android-app/

