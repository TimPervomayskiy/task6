#!/bin/bash

if [[ "$GIT_BRANCH" == "develop" ]]; then
  echo "I’m the best developer ever"
elif [[ "$GIT_BRANCH" == "master" ]]; then
  echo "I’m the best DevOps ever"
else
  echo "fail" $GIT_BRANCH
fi