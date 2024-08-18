#!/bin/bash

flutter test integration_test --coverage --no-pub

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
echo "Integration testing coverage is not included here"