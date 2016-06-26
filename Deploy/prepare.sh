#!/bin/bash
set -ex
SCRIPTSDIR="../dist/scripts"
PAT="^app.*\.js$"
IP=`ip route get 8.8.8.8 | awk '{ print $7;  }'` # get host ip

for FILE in `ls $SCRIPTSDIR` # loop file
do
    echo $FILE | grep -e $PAT > /dev/null
    if [ $? -eq 0 ];then
        sed -ie s/localhost/$IP/g $SCRIPTSDIR/$FILE > /dev/null #replace localhost to IP
        JSEFILE=`echo $FILE | sed -e s/\.js$/\.jse/`
        if [ -e $SCRIPTSDIR/$JSEFILE ];then # del jse file created by sed command
            rm $SCRIPTSDIR/*.jse > /dev/null
        fi
    fi
done
