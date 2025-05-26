#!/bin/bash
THRESHOLD=80

# Check CPU load
CPU_LOAD=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')

echo "CPU Load: $CPU_LOAD%"

if [ $(echo "$CPU_LOAD > $THRESHOLD" | bc -l) -eq 1 ]; then
    echo "Alert: CPU is above $THRESHOLD%"
fi

# Check memory usage
MEMORY=$(free | awk '/Mem:/ {printf "%.2f", $3/$2 * 100.0}')

echo "Memory Usage: $MEMORY%"

if [ $(echo "$MEMORY > $THRESHOLD" | bc -l) -eq 1 ]; then
    echo "Alert: MEMORY is above $THRESHOLD%"
fi

# Check disk space
DISK=$(df -h | awk '$NF=="/"{print $(NF-1)}' | sed 's/%//')

echo "Disk Usage: $DISK%"

if [ $(echo "$DISK > $THRESHOLD" | bc -l) -eq 1 ]; then
    echo "Alert: DISK is above $THRESHOLD%"
fi