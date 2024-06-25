#!bin/bash

if [[ $DIRSTACK == $HOME* ]];
then
    echo $HOME
    exit 0
else
    echo "An error occured. You must be in home directory"
    exit 1
fi
