#!/bin/sh

set -e

apk add git

cd /app

npm install

npm run dev