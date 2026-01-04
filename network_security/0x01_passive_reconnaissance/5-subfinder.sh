#!/bin/bash
subfinder -d "$1" -silent -all | xargs -I {} sh -c 'ip=$(dig +short {} | grep -E "^[0-9.]+$" | head -n1); if [ ! -z "$ip" ]; then echo "{},$ip"; fi' > "$1.txt"
