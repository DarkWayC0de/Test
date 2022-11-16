#!/bin/bash

local_branches() {
  git for-each-ref --format="%(refname:short)" refs/heads
}

# Returns the name of the current branch
current_branch() {
  git symbolic-ref --short HEAD
}

saved_branch=$(current_branch)

[[ "${saved_branch}" != "main" ]] && git checkout "main"
git pull

for branch in $(local_branches); do
  if [[ "${branch}" != "main" && "${branch}" != "mainSentinel" ]]; then
    echo
    git checkout "${branch}"
    git merge "main" -m "Merge main ${branch}."
    git push
  fi
done

echo
[[ "${saved_branch}" != "$(current_branch)" ]] && git checkout "${saved_branch}"
