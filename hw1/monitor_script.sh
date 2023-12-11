#!/bin/bash

while true; do
    cpu_utilization=$(top -l 1 -n 0 -stats cpu -pid 1 | awk '/^CPU usage:/ {print $3}')

    timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo "$timestamp;$cpu_utilization" >> monitor_results.csv

    sleep 10
done

