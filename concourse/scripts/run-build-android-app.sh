#!/bin/sh -e

./gradlew build

cp app/build/outputs/apk/app-debug.apk ../built-android-app

