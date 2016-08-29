#!/bin/bash
set -e
PWD=`pwd`
DIRLS=`ls git-repo/examples`
touch test.txt
echo $PWD >>test.txt
echo $DIRLS >>test.txt
