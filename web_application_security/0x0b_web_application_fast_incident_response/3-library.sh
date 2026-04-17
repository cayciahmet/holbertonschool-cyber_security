#!/bin/bash
# 1. Hücumçunun IP-sini tapırıq
ip=$(awk '{print $1}' logs.txt | sort | uniq -c | sort -nr | head -n 1 | awk '{print $2}')

# 2. Həmin IP-yə aid sətirləri süzür, cüt dırnaqlara (") görə bölür və 6-cı hissəni (User-Agent) tapırıq
grep "^$ip" logs.txt | awk -F'"' '{print $6}' | sort | uniq -c | sort -nr | head -n 1 | awk '{$1=""; sub(/^ /, ""); print}'
