#!/bin/bash

# Ensures that the brick is ready for a release.
# 
# Will update the brick.yaml file and update the CHANGELOG.md.
#
# Set it up for a new version:
# `./release_ready.sh <version>

# Check if current directory is usable for this script, if so we assume it is correctly set up.
if [ ! -f "brick.yaml" ]; then
  echo "$(pwd) is not a valid brick."
  exit 1
fi

currentBranch=$(git symbolic-ref --short -q HEAD)
if [[ ! $currentBranch == "main" ]]; then
 echo "Releasing is only supported on the main branch."
 exit 1
fi

# Get information
old_version=""
if [ -f "brick.yaml" ]; then
  old_version=$(cat brick.yaml | pcregrep 'version: (.*?)' | tr " " "\n" | tail -1)
fi

if [ -z "$old_version" ]; then
  echo "Current version was not resolved."
  exit 1
fi

# Get new version
new_version="$1";

if [[ "$new_version" == "" ]]; then 
  echo "No new version supplied, please provide one"
  exit 1
fi

if [[ "$new_version" == "$old_version" ]]; then
  echo "Current version is $old_version, can't update."
  exit 1
fi

# Retrieving all the commits in the current directory since the last tag.
previousTag="very_good_wear_app-v${old_version}"
raw_commits="$(git log --pretty=format:"%s" --no-merges --reverse $previousTag..HEAD -- .)"
markdown_commits=$(echo "$raw_commits" | sed -En "s/\(#([0-9]+)\)/([#\1](https:\/\/github.com\/VeryGoodOpenSource\/very_good_templates\/pull\/\1))/p")

if [[ "$markdown_commits" == "" ]]; then
  echo "No commits since last tag, can't update."
  exit 0
fi
commits=$(echo "$markdown_commits" | sed -En "s/^/- /p")

echo "Updating version to $new_version"
if [ -f "brick.yaml" ]; then
  sed -i '' "s/version: $old_version/version: $new_version/g" brick.yaml
fi

if grep -q v$new_version "CHANGELOG.md"; then
  echo "CHANGELOG already contains version $new_version."
  exit 1
fi

# Add a new version entry with the found commits to the CHANGELOG.md.
echo "# ${new_version} \n\n ${commits}\n\n$(cat CHANGELOG.md)" > CHANGELOG.md
echo "CHANGELOG generated, validate entries here: $(pwd)/CHANGELOG.md"

echo "Creating git branch for ver_good_cli@$new_version"
git checkout -b "chore/very_good_wear_app-v$new_version" > /dev/null

git add brick.yaml CHANGELOG.md 

echo ""
echo "Run the following command if you wish to commit the changes:"
echo "git commit -m \"chore(very_good_wear_app): v$new_version\""