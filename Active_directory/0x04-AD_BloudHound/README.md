# Active Directory - BloodHound Attack Path Analysis

This project-based module involves acting as a red team operator conducting a structured attack path analysis against a live Active Directory environment. Using BloodHound, the objective is to collect, visualize, and exploit the relationships between users, groups, computers, and ACLs within the `pentestlab.local` domain to achieve full domain compromise.

## Tasks Included
* 0. BloodHound Collection Entry Point
* 1. Password Spray + GenericAll ACL Discovery
* 2. Kerberoasting : svc_backup
* 3. AS-REP Roasting : jmartin
* 4. Disabled Account Enumeration : bh_auditor
* 5. Full Attack Chain → DCSync → Golden Ticket
* 6. SYSVOL/SMB Leak
