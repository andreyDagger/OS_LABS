#!/bin/bash
rm -rf ~/test
mkdir ~/test && ((echo "catalog test was created successfully" > ~/report); (touch ~/test/$(date +%d_%m_%Y_%H:%M)))

ping -c 1 "www.net_nikogo.ru" || (echo "$(date +%d_%m_%Y_%H:%M) error" > ~/report)
