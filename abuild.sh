#!/bin/bash
#  abuild.sh
#  
#
#  Created by n-d-k on 10/6/19.
#  
#
CLOVER_GIT_URL="https://github.com/CloverHackyColor/CloverBootloader.git"
GIT_DIR="Clover"
mkdir $GIT_DIR
git clone $CLOVER_GIT_URL $GIT_DIR

echo "Our tag: $TRAVIS_TAG"
cd $GIT_DIR

CLOVER_TAG=$(git describe --tags $(git rev-list --tags --max-count=1))
echo "Clover tag: $CLOVER_TAG"

LAST_COMMIT_MESSAGE=$(git log --pretty='format:%Creset%s' --no-merges -1)
echo "Last Clover commit message: $LAST_COMMIT_MESSAGE"

TRAVIS_COMMIT_MESSAGE=$LAST_COMMIT_MESSAGE

if [[ "$CLOVER_TAG" == "$TRAVIS_TAG" ]]; then
    echo "Build is up to date!"
    exit 0
else
    TRAVIS_TAG=$CLOVER_TAG
    ./buildme XCODE8 travis
fi
    

