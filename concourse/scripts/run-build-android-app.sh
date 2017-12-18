#!/bin/sh -e

./gradlew build
cp android-repo/app/build/outputs/apk/app-debug.apk built-android-app/
pwd
