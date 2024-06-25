#!/bin/bash
at -f "1.sh" now + 2 minute

while [ ! -f ~/report ]
do
:
done

tail -f ~/report | while read line
do
  echo $line
done
