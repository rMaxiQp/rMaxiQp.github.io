
git config user.name "${USER_NAME}"
git config user.email "${USER_EMAIL}"

git checkout master
git log HEAD..origin/master

git add .
git stash

# git pull -s recursive -X ours origin master

git rebase --onto master develop

# Remove all files except _site/* and dotfiles
find . -maxdepth 1 ! -name '_site' ! -name '.*' -exec rm -rf {} \;
mv _site/* .
rm -R _site/

# git reset --soft HEAD~1

git add -A .

git commit --allow-empty -m "[CircleCI Automation] $(git log develop -1 --pretty=%B)"

git push -q https://${USER_NAME}:${JEKYLL_GITHUB_TOKEN}@github.com/${USER_NAME}/rMaxiQp.github.io.git master