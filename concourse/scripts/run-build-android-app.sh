#!/bin/sh -e

./gradlew build
pwd
cp app/build/outputs/apk/app-debug.apk built-android-app/

