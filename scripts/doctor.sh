#!/usr/bin/env bash

# validate that .env file exists with a MOVIES_API_KEY=example differnet than example

if [ ! -f assets/.env ]; then
  cp assets/.env.example assets/.env
  echo "-> assets/.env created, go and fill with MOVIES_API_KEY variable."
  exit 1
else
  echo "-> assets/.env exists, go and fill with MOVIES_API_KEY variable."
fi
