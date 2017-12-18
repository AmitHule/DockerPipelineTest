#!/bin/sh -e

./gradlew build

chmod 777 ../built-android-app
pwd
cp app/build/outputs/apk/app-debug.apk ../built-android-app
pwd

