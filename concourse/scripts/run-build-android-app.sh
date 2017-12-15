#!/bin/sh -e

cd ios-repo/mechanic

carthage update --platform iOS --no-use-binaries

xcodebuild -project mechanic.xcodeproj -scheme mechanic -sdk iphoneos -archivePath "$ARCHIVE_FILENAME" -configuration AdHoc archive
xcodebuild -exportArchive -archivePath "$ARCHIVE_FILENAME" -exportPath build -exportOptionsPlist "Resources/ExportOptions.plist"
