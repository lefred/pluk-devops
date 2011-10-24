#!/bin/bash

#set -x
OLD_PATH=$(pwd)
cd "/var/lib/jenkins/jobs/${JOB_NAME}/tests"
pwd
mv results.new results.old 
cd "$OLD_PATH"
pwd
ruby tests/test.rb
old_results=( $(cat "/var/lib/jenkins/jobs/${JOB_NAME}/tests/results.old") )
new_results=( $(cat tests/results.new) )
cp tests/results.new "/var/lib/jenkins/jobs/${JOB_NAME}/tests/"
SUCCESS=0
total=${#old_results[@]}
i="0"
while [ $i -lt $total ]
do
   string_old=${old_results[$i]}
   string_new=${new_results[$i]}
   if [ $(expr match "$string_old" '[0-9]*\([a-z]*\)') == $(expr match "$string_new}" '[0-9]*\([a-z]*\)') ] 
   then 
        if [ "$(expr match "$string_new" '\([0-9]*\)')" -lt "$(expr match "$string_old" '\([0-9]*\)')" ]
	then
	    echo it is better now  ${new_results[$i]} vs  ${old_results[$i]}
	elif [  $(expr match "$string_new" '\([0-9]*\)') -eq  $(expr match "$string_old" '\([0-9]*\)') ]
	then
	    echo it is the same now  ${new_results[$i]} vs  ${old_results[$i]} 
            SUCCESS=1
	else
	    echo it is worse now  ${new_results[$i]} vs  ${old_results[$i]}
            SUCCESS=2
        fi
   else 
       if [ $(expr match "$string_new" '[0-9]*\([a-z]*\)') == "ms" ]
       then 
	    echo it is better now  ${new_results[$i]} vs  ${old_results[$i]}
       else
	    echo it is worse now  ${new_results[$i]} vs  ${old_results[$i]}
            SUCCESS=2
       fi
   fi
   i=$[$i+1]
done

if [ $SUCCESS -eq 0 ]
then
   echo "SUCCESS"
   exit $SUCCESS
elif [ $SUCCESS -eq 1 ]
then
   echo "UNSTABLE"
   exit $SUCCESS
else
   echo "FAILURE"
   exit $SUCCESS
fi
