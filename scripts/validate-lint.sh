#!/usr/bin/env bash

COMMANDS=(
  "flutter analyze --no-pub --no-fatal-infos --no-fatal-warnings"
  "dart run dart_code_linter:metrics check-unused-code lib test"
  "dart run dart_code_linter:metrics check-unused-files lib test"
  "dart run dart_code_linter:metrics analyze lib test"
  "dart run dart_code_linter:metrics check-unnecessary-nullable lib test"
)

for COMMAND in "${COMMANDS[@]}"; do
  echo "--> Running: $COMMAND"

  RESULT=$($COMMAND)
  echo "$RESULT"

  if [[ $RESULT == *"error •"* || $RESULT == *"ALARM"* || $RESULT == *"WARNING"* ]]; then
    echo "----> :O Command $COMMAND failed"
    exit 1
  else
    echo "----> Command $COMMAND ran successfully :)"
  fi
done
