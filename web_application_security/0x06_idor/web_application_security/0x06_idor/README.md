# 0x06. Web Application Security - IDOR

## Description
This project focuses on understanding and exploiting **Insecure Direct Object References (IDOR)** vulnerabilities. The practical tasks are carried out on a custom-built vulnerable banking application called **CyberBank**. 

The main objective is to understand how poor access control configurations and predictable object references can allow unauthorized users to access, modify, or delete data belonging to other users.

## Learning Objectives
* What is an Insecure Direct Object Reference (IDOR)?
* How to identify IDOR vulnerabilities in web applications and APIs.
* How to manipulate parameters (like user IDs, account numbers, etc.) to bypass authorization mechanisms.
* Understanding the difference between authentication and authorization.

## Tasks

### 0. Navigating the IDOR Waters through A Banking Adventure
* **Objective:** Log into the CyberBank application, monitor network traffic and API endpoints to discover how user IDs are structured. Find a way to expose other users' IDs and use them to access unauthorized profile information to retrieve the hidden flag.
* **Target:** `http://web0x06.hbtn/dashboard`
* **File:** `0-flag.txt`
