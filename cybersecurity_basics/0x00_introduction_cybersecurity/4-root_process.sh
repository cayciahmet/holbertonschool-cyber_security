#!/bin/bash
ps -U "$1" -u "$1" u --no-headers | grep -v " 0  *0 "
