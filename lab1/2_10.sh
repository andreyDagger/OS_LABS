#!bin/bash
man bash | tr [:upper:] [:lower:] | tr -s [:punct:][:space:] '\n' | awk 'length($0) >= 4' | sort | uniq -c | sort -nr | head -3
