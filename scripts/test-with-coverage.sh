#!/bin/bash

flutter test --coverage --no-pub
mv coverage/lcov.info coverage/lcov.unit.info

flutter test integration_test --coverage --no-pub

echo "-> Join all coverage files"
lcov --add-tracefile coverage/lcov.unit.info --add-tracefile coverage/lcov.info --output-file coverage/lcov.info

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