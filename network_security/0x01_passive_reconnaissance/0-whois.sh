#!/bin/bash
whois "$1" | awk 'BEGIN{
 FS=":";
 f="Registrant Name,Registrant Organization,Registrant Street,Registrant City,Registrant State/Province,Registrant Postal Code,Registrant Country,Registrant Phone,Registrant Phone Ext,Registrant Fax,Registrant Fax Ext,Registrant Email,Admin Name,Admin Organization,Admin Street,Admin City,Admin State/Province,Admin Postal Code,Admin Country,Admin Phone,Admin Phone Ext,Admin Fax,Admin Fax Ext,Admin Email,Tech Name,Tech Organization,Tech Street,Tech City,Tech State/Province,Tech Postal Code,Tech Country,Tech Phone,Tech Phone Ext,Tech Fax,Tech Fax Ext,Tech Email";
 split(f,K,",");
}
{
 sub(/^[ \t]+/,"",$2); gsub(/[ \t]+$/,"",$2);
 if($1 ~ /^Registrant Name/) d["Registrant Name"]=$2;
 if($1 ~ /^Registrant Organization/) d["Registrant Organization"]=$2;
 if($1 ~ /^Registrant Street/) d["Registrant Street"]=$2" ";
 if($1 ~ /^Registrant City/) d["Registrant City"]=$2;
 if($1 ~ /^Registrant State\/Province/) d["Registrant State/Province"]=$2;
 if($1 ~ /^Registrant Postal Code/) d["Registrant Postal Code"]=$2;
 if($1 ~ /^Registrant Country/) d["Registrant Country"]=$2;
 if($1 ~ /^Registrant Phone/) d["Registrant Phone"]=$2;
 if($1 ~ /^Registrant Phone Ext/) d["Registrant Phone Ext"]=$2;
 if($1 ~ /^Registrant Fax/) d["Registrant Fax"]=$2;
 if($1 ~ /^Registrant Fax Ext/) d["Registrant Fax Ext"]=$2;
 if($1 ~ /^Registrant Email/) d["Registrant Email"]=$2;
 if($1 ~ /^Admin Name/) d["Admin Name"]=$2;
 if($1 ~ /^Admin Organization/) d["Admin Organization"]=$2;
 if($1 ~ /^Admin Street/) d["Admin Street"]=$2" ";
 if($1 ~ /^Admin City/) d["Admin City"]=$2;
 if($1 ~ /^Admin State\/Province/) d["Admin State/Province"]=$2;
 if($1 ~ /^Admin Postal Code/) d["Admin Postal Code"]=$2;
 if($1 ~ /^Admin Country/) d["Admin Country"]=$2;
 if($1 ~ /^Admin Phone/) d["Admin Phone"]=$2;
 if($1 ~ /^Admin Phone Ext/) d["Admin Phone Ext"]=$2;
 if($1 ~ /^Admin Fax/) d["Admin Fax"]=$2;
 if($1 ~ /^Admin Fax Ext/) d["Admin Fax Ext"]=$2;
 if($1 ~ /^Admin Email/) d["Admin Email"]=$2;
 if($1 ~ /^Tech Name/) d["Tech Name"]=$2;
 if($1 ~ /^Tech Organization/) d["Tech Organization"]=$2;
 if($1 ~ /^Tech Street/) d["Tech Street"]=$2" ";
 if($1 ~ /^Tech City/) d["Tech City"]=$2;
 if($1 ~ /^Tech State\/Province/) d["Tech State/Province"]=$2;
 if($1 ~ /^Tech Postal Code/) d["Tech Postal Code"]=$2;
 if($1 ~ /^Tech Country/) d["Tech Country"]=$2;
 if($1 ~ /^Tech Phone/) d["Tech Phone"]=$2;
 if($1 ~ /^Tech Phone Ext/) d["Tech Phone Ext"]=$2;
 if($1 ~ /^Tech Fax/) d["Tech Fax"]=$2;
 if($1 ~ /^Tech Fax Ext/) d["Tech Fax Ext"]=$2;
 if($1 ~ /^Tech Email/) d["Tech Email"]=$2;
}
END {
 for(i=1;i<=36;i++){
  k=K[i]; v=d[k];
  if(k~/Ext/ && v=="") print k ":,";
  else if(k~/Ext/) print k ":," v;
  else if(k~/Street/ && v==" ") print k ",";
  else print k ", " v;
 }
}' > "$1.csv"
