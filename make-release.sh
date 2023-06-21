export VERSION=$1

GIT_REMOTE="origin"
GIT_BRANCH=$(git branch | sed -n '/\* /s///p')

echo "Making release with version $VERSION from branch '$GIT_BRANCH'"
echo "Set version in package.json"

jq ".version=\"$VERSION\"" ./package.json > ./package.json.tmp && mv ./package.json.tmp ./package.json

echo "Commiting to git"
git add .

git commit -m "Release v$VERSION"
git tag -a "$VERSION" -m "Release v$VERSION"

echo "Pushing to git"
git push $GIT_REMOTE "$GIT_BRANCH"
git push $GIT_REMOTE "$VERSION"

