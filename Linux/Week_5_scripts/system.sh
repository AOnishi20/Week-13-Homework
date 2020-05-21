#!/bin/bash
#Part 1 of Week 5 Homwork
mkdir ~/home
mkdir ~/home/backups
mkdir ~/home/backups/freemen
mkdir ~/home/backups/diskuse
mkdir ~/home/backups/openlist
mkdir ~/home/backups/freedisk
#Part 2 of Week 5 Homework
free -h | awk 'FNR == 2 {print $4}' > ~/home/backups/freemen/free_mem.txt
du -h > ~/home/backups/diskuse/disk_usage.txt
lsof > ~/home/backups/openlist/openlist.txt
df -h > ~/home/backups/freedisk/freedisk.txt

