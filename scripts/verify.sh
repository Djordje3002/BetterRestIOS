#!/bin/sh
set -eu
cd "$(dirname "$0")/.."
mkdir -p .build/module-cache .build/generated
xcrun swiftc -module-cache-path .build/module-cache \
  BetterRest/SleepPreferences.swift BetterRest/BedtimeSchedule.swift Tests/main.swift \
  -o .build/schedule-tests
.build/schedule-tests
xcrun coremlc generate BetterRest/SleepCalculator.mlmodel .build/generated --language Swift
sdk_path=$(xcrun --sdk iphonesimulator --show-sdk-path)
xcrun swiftc -typecheck -parse-as-library -target arm64-apple-ios17.0-simulator \
  -sdk "$sdk_path" -module-cache-path .build/module-cache \
  BetterRest/*.swift .build/generated/*.swift
echo "iOS Simulator source type-check passed"
