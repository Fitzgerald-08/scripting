import os
import sys


if len(sys.argv) == 2:
    filename = sys.argv[1]

    if not os.access(filename, os.R_OK):
        print(f"[-] access denied")
        exit(1)

    if not os.access(filename, os.F_OK):
        print(f"{filename} does not exist")
        exit(1)

    print(f"[+] {filename} is a file with write permissions")
