#!/bin/bash
tail -n 1000 auth.log | grep "Accepted" | awk '{print $9}' | sort | uniq -c | sort -nr | head -n 1 | awk '{print $2}'
