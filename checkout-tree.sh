#!/bin/bash
REPOSITORY="git://github.com/php/php-src.git"

usage() {
    cat <<EOF
checkout-tree <directory> <repository-url>

Checkout the PHP sourcecode from Github and reinitialize git-svn.
Run this script to get a valid git-svn repository that can be used to commit
back to svn.php.net.
EOF
}

if test $# -eq 2
then
    REPOSITORY=$2
elif test $# -ne 1
then
    usage;
    exit 255;
fi


DIR=$1

echo "Repository: $REPOSITORY"
echo "Directroy:  $DIR"
echo "Initialize..."

(mkdir $DIR && cd $DIR && git init &&git remote add origin $REPOSITORY && git config remote.origin.fetch 'refs/remotes/*:refs/remotes/*' && git fetch &&
git checkout -b master trunk && git svn init -s http://svn.php.net/repository/php/php-src/ && git svn rebase)
