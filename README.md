# System Vulnerability Auditor Script

This bash script is designed for basic security auditing of Unix-like systems. It provides a menu to help system administrators or security auditors quickly identify potential security risks related to sensitive files, processes running as root, and binaries with special permissions (SUID/SGID). 

The script allows for:
- **Identifying files with known credentials** that may be misconfigured.
- **Listing processes owned by root** which could be a target for exploitation.
- **Finding SUID/SGID binaries**, which could allow privilege escalation if not properly secured.

## Features

- **Option 1**: Search for files containing the word "password" in `/etc/` and `/var/log/` directories that may contain sensitive information.
- **Option 2**: Display processes that are running as root, potentially vulnerable to exploitation.
- **Option 3**: List SUID/SGID binaries that have special permissions, which could be exploited if misconfigured.
- **User-specific results**: After selecting any of the first three options, you can view results specific to a user (files, processes, and SUID/SGID binaries associated with that user).

## How It Works

1. The script presents a menu with the following options:
   - **Files with Known Credentials**: Finds files with "password" in the `/etc/` and `/var/log/` directories.
   - **Processes Owned by Root**: Lists processes running under the `root` user.
   - **SUID/SGID Binaries**: Finds binaries with SUID or SGID permissions.
   - **Exit**: Exits the script.

2. After selecting an option, the script will:
   - Display relevant information for that option.
   - Ask if you'd like to see results by user, which will prompt you for a username and then display results specific to that user.

## Usage

1. **Clone or Download the Script**:
   Download or clone this repository to your local machine.

2. **Run the Script**:
   Run the script on a Linux-based system using bash. Ensure that you have the necessary permissions to access system directories and process information.

   ```bash
   chmod +x system_vulnerability_auditor.sh
   ./system_vulnerability_auditor.sh
Select an Option: The script will display a menu. Choose one of the available options:

1: Files with known credentials.
2: Processes owned by root.
3: SUID/SGID binaries.
4: Exit the script.
Optional: View Results by User: After selecting an option, the script will ask if you want to view results filtered by user. Enter a username to see files, processes, and binaries specific to that user.

**Example Output**
- ****Option 1: Files with Known Credentials**
- javascript
- Copy code
- These files may contain credentials that can be used to escalate privileges:
/etc/passwd
/var/log/auth.log
- ****Option 2: Processes Owned by Root**
- yaml
- Copy code
- These processes are owned by root and may be vulnerable to exploitation:
root       1234  0.0  0.1  23456  6789 ?        Ss   10:00   0:00 /usr/sbin/sshd
root       5678  0.0  0.1  23456  6789 ?        Ss   10:05   0:00 /usr/sbin/apache2
- ****Option 3: SUID/SGID Binaries**
- bash
- Copy code
- These binaries have special permissions and may be vulnerable to exploitation:
-rwsr-xr-x 1 root root 23456 /usr/bin/sudo
-rwsr-xr-x 1 root root 12345 /usr/bin/passwd
**Example User-Specific Results:**
yaml
Copy code
Results for User: username
------------------
Files containing the word "password":
/etc/username_passwords
/var/log/username_auth.log

Processes owned by username:
username   1234  0.1  0.2  45678  1234 ?        S    10:15   0:00 /usr/bin/username_process

SUID/SGID binaries owned by username:
-rwsr-xr-x 1 username root 12345 /usr/bin/username_suid_binary
Security Considerations
This script is intended for use in controlled environments and for authorized security audits only. Unauthorized access to or modification of system files, processes, or configurations is illegal and unethical. Always ensure you have explicit permission to audit systems before running this or similar scripts.

License
This script is released for educational purposes only. **It is not intended for malicious use. Use this script responsibly and ensure you have proper authorization.**

Disclaimer
The script may not work on all systems, as it relies on Unix/Linux-specific commands and directories.
The author is not responsible for any damage or misuse of the script.
