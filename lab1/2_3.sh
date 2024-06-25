#!bin/bash

while true
do
echo -e "Choose the one you want to open:\n1) Nano\n2) Vi\n3) Browser links\n4) Exit"
read in
if [ $in == "1" ]
then
    nano
elif [ $in == "2" ]
then
    vi
elif [ $in == "3" ]
then
    links
elif [ $in == "4" ]
then
    break
fi
done
