#!bin/bash
find /var/log -name "*.log" -print0 | xargs -0 cat | wc -l
