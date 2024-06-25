#!bin/bash
email_regex="[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}"
emails=$(grep -hrEoa $email_regex /etc | sort | uniq)
echo $emails > emails.lst
result=$(tr ' ' ',' < emails.lst)
echo $result > emails.lst
