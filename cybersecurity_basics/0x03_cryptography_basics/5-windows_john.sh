#!/bin/bash
john --format=nt --wordlist=/usr/share/wordlists/rockyou.txt "$1" && john --show --format=nt "$1" | awk -F: 'NF>1 {print $2}' > 5-password.txt
