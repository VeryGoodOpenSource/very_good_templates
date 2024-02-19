# Ensures that the package or brick is ready for a release.
#
# Set it up for a new version:
# `./release_ready.sh <version>

# Check if current directory is usable for this script, if so we assume it is correctly set up.
if [ ! -f "brick/brick.yaml" ]; then
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
current_name=""
if [ -f "brick/brick.yaml" ]; then
  old_version=$(cat brick/brick.yaml | pcregrep 'version: (.*?)' | tr " " "\n" | tail -1)
  current_name=$(cat brick/brick.yaml | pcregrep 'name: (.*?)' | tr " " "\n" | tail -1)
fi

if [ -z "$old_version" ] || [ -z "$current_name" ]; then
  echo "Current version or name was not resolved."
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
previousTag="v${old_version}"
raw_commits="$(git log --pretty=format:"%s" --no-merges --reverse $previousTag..HEAD -- .)"
markdown_commits=$(echo "$raw_commits" | sed -En "s/\(#([0-9]+)\)/([#\1](https:\/\/github.com\/VeryGoodOpenSource\/very_good_core\/pull\/\1))/p")

if [[ "$markdown_commits" == "" ]]; then
  echo "No commits since last tag, can't update."
  exit 0
fi
commits=$(echo "$markdown_commits" | sed -En "s/^/- /p")

echo "Updating version to $new_version"
if [ -f "brick/brick.yaml" ]; then
  sed -i '' "s/version: $old_version/version: $new_version/g" brick/brick.yaml
fi

# Update dart file with new version.
dart run build_runner build --delete-conflicting-outputs > /dev/null

if grep -q $new_version "brick/CHANGELOG.md"; then
  echo "CHANGELOG already contains version $new_version."
  exit 1
fi

# Add a new version entry with the found commits to the brick/CHANGELOG.md.
echo "# ${new_version}\n\n${commits}\n\n$(cat brick/CHANGELOG.md)" > brick/CHANGELOG.md
echo "CHANGELOG for $current_name generated, validate entries here: $(pwd)/brick/CHANGELOG.md"

echo "Creating git branch for $current_name@$new_version"
git checkout -b "chore/v$new_version" > /dev/null

git add brick/brick.yaml brick/CHANGELOG.md

echo ""
echo "Run the following command if you wish to commit the changes:"
echo "git commit -m \"chore: v$new_version\""