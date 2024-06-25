#!bin/bash

full=""
while true
do
    read tmp
    if [[ $tmp == "q" ]]
    then
       break
    fi
    full="${full}${tmp}"
done
echo $full
