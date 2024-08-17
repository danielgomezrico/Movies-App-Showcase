#!/bin/bash

flutter test --coverage --no-pub

echo "-> Cleaning not wanted files from coverage"
brew install lcov
lcov --remove coverage/lcov.info \
  '**.g.dart' \
  '**.chopper.dart' \
  'lib/generated/**' \
  'test/**.mocks.dart' \
  '.fvm/**' \
  '*/fastlane/**' \
  --ignore-errors unused \
  -o coverage/lcov_cleaned.info
genhtml coverage/lcov_cleaned.info -o coverage/html

echo "--> Check coverage report at coverage/html/index.html"