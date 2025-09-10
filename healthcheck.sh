#!/bin/bash

# Author : naveen
# Date   : 10/09/25
# This script outputs the node health

############################################
# Debug mode
set -x

LOG_FILE="healthlog.txt"

{
    echo "print the system date and time"
    date

    echo "print the uptime"
    uptime -p

    echo "print the CPU load"
    uptime | awk -F'load average:' '{ print $2 }'

    echo "print the memory usage"
    free -m
    echo "print the disk usage"
    df -h

    echo "print top 5 memory consuming processes"
    ps aux --sort=-%mem | head -n 6

    echo "check nginx status"
    if systemctl is-active --quiet nginx
    then
        echo "nginx is working"
    else
        echo "nginx is not working"
    fi

    echo "check ssh status"
if systemctl is-active --quiet ssh
    then
        echo "ssh is working"
    else
        echo "ssh is not working"
    fi
} >> "$LOG_FILE"
