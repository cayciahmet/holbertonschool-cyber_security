#!/bin/bash
grep "new user" "${1:-auth.log}" | awk -F'[,=]' '{print $2}' | sort | uniq | paste -sd "," -
