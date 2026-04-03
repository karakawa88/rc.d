#!/bin/bash

git checkout main
git merge dev
git push github dev
git push github main
git checkout dev

exit 0

