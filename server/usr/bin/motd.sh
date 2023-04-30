#!/bin/bash
# Based on https://github.com/lfelipe1501/Arch-MOTD modifications by Elliot Hatch 2019
# Apache License 2.0: https://github.com/lfelipe1501/Arch-MOTD/blob/85d02347d37133853102af816de044146f93a019/LICENSE.md

# Collect information
HOSTNAME=`uname -n`
KERNEL=`uname -r`
CPU=`awk -F '[ :][ :]+' '/^model name/ { print $2; exit; }' /proc/cpuinfo`
ARCH=`uname -m`
PACMAN=`checkupdates --nosync | wc -l`
DISKUSE=`df -h | grep /dev/sda1 | head -n 1 | awk '{print $3 }'`
DISKTOTAL=`df -h | grep /dev/sda1 | head -n 1 | awk '{print $2 }'`
DISKPCT=`df -h | grep /dev/sda1 | head -n 1 | awk '{print $5 }'`
DISK2USE=`df -h | grep /dev/sdd2 | head -n 1 | awk '{print $3 }'`
DISK2TOTAL=`df -h | grep /dev/sdd2 | head -n 1 | awk '{print $2 }'`
DISK2PCT=`df -h | grep /dev/sdd2 | head -n 1 | awk '{print $5 }'`
MEMORY1=`free -t -h | grep "Mem" | awk '{print $6;}'`
MEMORY2=`free -t -h | grep "Mem" | awk '{print $2;}'`

#Time of day
HOUR=$(date +"%H")
if [ $HOUR -lt 12  -a $HOUR -ge 0 ]
then   TIME="Morning"
elif [ $HOUR -lt 17 -a $HOUR -ge 12 ]
then   TIME="Afternoon"
else   TIME="Evening"
fi

#System uptime
uptime=`cat /proc/uptime | cut -f1 -d.`
upDays=$((uptime/60/60/24))
upHours=$((uptime/60/60%24))
upMins=$((uptime/60%60))
upSecs=$((uptime%60))


#System load
LOAD1=`cat /proc/loadavg | awk {'print $1'}`
LOAD5=`cat /proc/loadavg | awk {'print $2'}`
LOAD15=`cat /proc/loadavg | awk {'print $3'}`

#Color variables
#W="\033[00;37m"
W="\033[0m"
B="\033[01;36m"
R="\033[01;31m"
G="\033[01;32m"
N="\033[0m"

#Clear screen before motd
# cat /dev/null > $motd
echo -e "
$B  ______________________________ 
 |   _         _                |\\
 |  ( )___ ___| |__  _____  __  | |
 |  | /  _/ _ \  _ \/ _ \ \/ /  | |
 |  | | (_| __/ |_)| (_)/   /   | |
 |  |_\___\___|____/\__/_/\_\   | |
 |______________________________| |
 \_______________________________\|
"
echo -e "$G---------------------------------------------------------------"
echo -e "$W   Good $TIME$A. The time is $(date '+%r %Z')"
echo -e "$W   $(date '+%A, %B %-d, %Y')"
echo -e "$G---------------------------------------------------------------"
echo -e "$B    KERNEL $G:$W $KERNEL $ARCH"
echo -e "$B       CPU $G:$W $CPU"
echo -e "$B    MEMORY $G:$W $MEMORY1 / $MEMORY2"
echo -e "$B DATA DISK $G:$W $DISKUSE / $DISKTOTAL ($DISKPCT)"
echo -e "$B   OS DISK $G:$W $DISK2USE / $DISK2TOTAL ($DISK2PCT)"
echo -e "$G---------------------------------------------------------------"
echo -e "$B  LOAD AVG $G:$W $LOAD1, $LOAD5, $LOAD15"
echo -e "$B    UPTIME $G:$W $upDays days $upHours hours $upMins minutes $upSecs seconds"
#echo -e "$B PROCESSES $G:$W You are running $PSU of $PSA processes        "
echo -e "$B    PACMAN $G:$W $PACMAN packages can be updated"
echo -e "$B     USERS $G:$W `users | wc -w` users logged in"
echo -e "$G---------------------------------------------------------------"
