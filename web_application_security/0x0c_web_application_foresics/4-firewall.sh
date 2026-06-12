#!/bin/bash
grep "iptables" "${1:-auth.log}" | grep "\-A" | wc -l | xargs
