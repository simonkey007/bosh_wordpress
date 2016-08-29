#!/bin/bash
set -e
PWD=`pwd`
DIRLS=`ls examples`
touch test.txt
echo $PWD >>test.txt
echo $DIRLS >>test.txt
