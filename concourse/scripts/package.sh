#!/bin/bash

set -e
export TERM=dumb # needed for Gradle: https://issues.gradle.org/browse/GRADLE-2634

pushd project-source
./gradlew assemble
popd

cp project-source/build/outputs/apk/github-debug.apk package/dis.apk