#!/bin/bash

# Check if domain argument is provided
if [ -z "$1" ]; then
    echo "Usage: ./0-whois.sh <domain>"
    exit 1
fi

DOMAIN=$1
OUTPUT_FILE="${DOMAIN}.csv"

# Perform whois lookup and process with awk
whois "$DOMAIN" | awk '
BEGIN {
    # Define fields to extract in order
    fields[1]="Registrant Name"; fields[2]="Registrant Organization"; fields[3]="Registrant Street";
    fields[4]="Registrant City"; fields[5]="Registrant State/Province"; fields[6]="Registrant Postal Code";
    fields[7]="Registrant Country"; fields[8]="Registrant Phone"; fields[9]="Registrant Phone Ext";
    fields[10]="Registrant Fax"; fields[11]="Registrant Fax Ext"; fields[12]="Registrant Email";
    
    fields[13]="Admin Name"; fields[14]="Admin Organization"; fields[15]="Admin Street";
    fields[16]="Admin City"; fields[17]="Admin State/Province"; fields[18]="Admin Postal Code";
    fields[19]="Admin Country"; fields[20]="Admin Phone"; fields[21]="Admin Phone Ext";
    fields[22]="Admin Fax"; fields[23]="Admin Fax Ext"; fields[24]="Admin Email";
    
    fields[25]="Tech Name"; fields[26]="Tech Organization"; fields[27]="Tech Street";
    fields[28]="Tech City"; fields[29]="Tech State/Province"; fields[30]="Tech Postal Code";
    fields[31]="Tech Country"; fields[32]="Tech Phone"; fields[33]="Tech Phone Ext";
    fields[34]="Tech Fax"; fields[35]="Tech Fax Ext"; fields[36]="Tech Email";
}

{
    # Remove leading/trailing whitespace
    gsub(/^[ \t]+|[ \t]+$/, "", $0)
    
    # Check for matches
    if ($0 ~ /^Registrant Name:/) data["Registrant Name"] = substr($0, index($0, ":")+2)
    if ($0 ~ /^Registrant Organization:/) data["Registrant Organization"] = substr($0, index($0, ":")+2)
    if ($0 ~ /^Registrant Street:/) data["Registrant Street"] = substr($0, index($0, ":")+2) " "
    if ($0 ~ /^Registrant City:/) data["Registrant City"] = substr($0, index($0, ":")+2)
    if ($0 ~ /^Registrant State\/Province:/) data["Registrant State/Province"] = substr($0, index($0, ":")+2)
    if ($0 ~ /^Registrant Postal Code:/) data["Registrant Postal Code"] = substr($0, index($0, ":")+2)
    if ($0 ~ /^Registrant Country:/) data["Registrant Country"] = substr($0, index($0, ":")+2)
    if ($0 ~ /^Registrant Phone:/) data["Registrant Phone"] = substr($0, index($0, ":")+2)
    if ($0 ~ /^Registrant Phone Ext:/) data["Registrant Phone Ext"] = substr($0, index($0, ":")+2)
    if ($0 ~ /^Registrant Fax:/) data["Registrant Fax"] = substr($0, index($0, ":")+2)
    if ($0 ~ /^Registrant Fax Ext:/) data["Registrant Fax Ext"] = substr($0, index($0, ":")+2)
    if ($0 ~ /^Registrant Email:/) data["Registrant Email"] = substr($0, index($0, ":")+2)

    if ($0 ~ /^Admin Name:/) data["Admin Name"] = substr($0, index($0, ":")+2)
    if ($0 ~ /^Admin Organization:/) data["Admin Organization"] = substr($0, index($0, ":")+2)
    if ($0 ~ /^Admin Street:/) data["Admin Street"] = substr($0, index($0, ":")+2) " "
    if ($0 ~ /^Admin City:/) data["Admin City"] = substr($0, index($0, ":")+2)
    if ($0 ~ /^Admin State\/Province:/) data["Admin State/Province"] = substr($0, index($0, ":")+2)
    if ($0 ~ /^Admin Postal Code:/) data["Admin Postal Code"] = substr($0, index($0, ":")+2)
    if ($0 ~ /^Admin Country:/) data["Admin Country"] = substr($0, index($0, ":")+2)
    if ($0 ~ /^Admin Phone:/) data["Admin Phone"] = substr($0, index($0, ":")+2)
    if ($0 ~ /^Admin Phone Ext:/) data["Admin Phone Ext"] = substr($0, index($0, ":")+2)
    if ($0 ~ /^Admin Fax:/) data["Admin Fax"] = substr($0, index($0, ":")+2)
    if ($0 ~ /^Admin Fax Ext:/) data["Admin Fax Ext"] = substr($0, index($0, ":")+2)
    if ($0 ~ /^Admin Email:/) data["Admin Email"] = substr($0, index($0, ":")+2)

    if ($0 ~ /^Tech Name:/) data["Tech Name"] = substr($0, index($0, ":")+2)
    if ($0 ~ /^Tech Organization:/) data["Tech Organization"] = substr($0, index($0, ":")+2)
    if ($0 ~ /^Tech Street:/) data["Tech Street"] = substr($0, index($0, ":")+2) " "
    if ($0 ~ /^Tech City:/) data["Tech City"] = substr($0, index($0, ":")+2)
    if ($0 ~ /^Tech State\/Province:/) data["Tech State/Province"] = substr($0, index($0, ":")+2)
    if ($0 ~ /^Tech Postal Code:/) data["Tech Postal Code"] = substr($0, index($0, ":")+2)
    if ($0 ~ /^Tech Country:/) data["Tech Country"] = substr($0, index($0, ":")+2)
    if ($0 ~ /^Tech Phone:/) data["Tech Phone"] = substr($0, index($0, ":")+2)
    if ($0 ~ /^Tech Phone Ext:/) data["Tech Phone Ext"] = substr($0, index($0, ":")+2)
    if ($0 ~ /^Tech Fax:/) data["Tech Fax"] = substr($0, index($0, ":")+2)
    if ($0 ~ /^Tech Fax Ext:/) data["Tech Fax Ext"] = substr($0, index($0, ":")+2)
    if ($0 ~ /^Tech Email:/) data["Tech Email"] = substr($0, index($0, ":")+2)
}

END {
    # Print fields in the specified order
    for (i = 1; i <= 36; i++) {
        key = fields[i]
        val = data[key]
        
        # Handle empty Ext fields to ensure colon is present
        if (key ~ /Ext$/ && val == "") {
            print key ":,"
        } 
        # Handle Street specifically (already added space, but check if empty)
        else if (key ~ /Street$/ && val == " ") {
             # If street was empty but space added, print empty value
             print key ","
        }
        else if (key ~ /Street$/) {
             print key "," val
        }
        else {
            print key "," val
        }
    }
}' > "$OUTPUT_FILE"
