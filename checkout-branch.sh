#!/bin/bash
REPOSITORY="git://github.com/php/php-src.git"

usage() {
    cat <<EOF
checkout-branch <directory> <branch> <repository-url>

Checkout a specific branch from the PHP sourcecode from Github and reinitialize git-svn.
Run this script to get a valid git-svn repository that can be used to commit
back to svn.php.net.
EOF
}

if test $# -eq 3
then
    REPOSITORY=$3
elif test $# -ne 2
then
    usage;
    exit 255;
fi


DIR=$1
BRANCH=$2

if test "$BRANCH" = "trunk"
then
    URL_EXT="trunk";
else
    URL_EXT="branches/$BRANCH"
fi

echo "Repository: $REPOSITORY"
echo "Directroy:  $DIR"
echo "Branch:     $BRANCH"
echo "Initialize..."

(mkdir $DIR && cd $DIR && git init &&git remote add origin $REPOSITORY && git config remote.origin.fetch "refs/remotes/$BRANCH:refs/remotes/git-svn" &&
git fetch && git checkout -b master remotes/git-svn && git svn init http://svn.php.net/repository/php/php-src/$URL_EXT && git svn rebase)
