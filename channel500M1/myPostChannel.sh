#!/bin/sh
# cd ${0%/*} || exit 1    # Run from this directory
. $WM_PROJECT_DIR/bin/tools/RunFunctions
echo $1
if [ -d "processor0/$1" ]; then
reconstructPar -time $1
postChannel -time $1
else
echo "processor*/$1 doesn't exit, check it."
exit
fi