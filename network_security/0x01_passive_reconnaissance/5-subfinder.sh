#!/bin/bash
subfinder -d "$1" -silent | while read sub; do
    ip=$(dig +short "$sub" | grep -E '^[0-9.]+$' | head -n 1)
    if [ ! -z "$ip" ]; then
        echo "$sub,$ip"
    fi
done > "$1.txt"
