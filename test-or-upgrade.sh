#!/bin/bash

set -o xtrace

# if [ "$TRAVIS_EVENT_TYPE" = "cron" ]; then
echo "Upgrading dependencies using next-update"
npm i -g next-update
next-update -m ggit --allow patch
git status
# if package.json is modified we have
# new upgrades
if git diff --name-only | grep package.json > /dev/null; then
  echo "There are new versions of dependencies 💪"
  git add package.json
  git config --global user.email "travis@ci.com"
  git config --global user.name "next-update"
  git commit -m "chore(deps): upgraded dependencies with next-update"
else
  echo "No new versions found ✋"
fi
# else
#   echo "Not a cron job, normal test"
#   npm test
# fi

