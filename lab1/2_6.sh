#!bin/bash
grep '^\[.*(WW)' /var/log/Xorg.0.log > full.log
grep '^\[.*(II)' /var/log/Xorg.0.log >> full.log
sed -i 's/(WW)/Warning/g' full.log
sed -i 's/(II)/Information/g' full.log
