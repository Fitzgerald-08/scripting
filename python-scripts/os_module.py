import os
import sys
import time
from collections import Counter

"""
In this portion of code, I am allowed to walk the a specific location
of the file system and print its contents

- dirpath: The relative "root" directoy I am scanning.
- dirnames: Returnes all the directories in the current directory.
- filenames: Like dirnames, retrives all the files found.

for dirpath, dirnames, filenames in os.walk(os.getcwd(), topdown=True):

    for dir in dirnames:
        print(dir)

    for file in filenames:
        print(file)
"""

"""
if len(sys.argv) == 2:
    env_var = sys.argv[1].upper()

    for _ in os.environ:
        if _ == env_var:
            print(f"{_}: {os.environ[_]}")

counter = Counter()

for dirpath, dirnames, filenames in os.walk(os.getcwd()):
    for filename in filenames:
        file, extension = os.path.splitext(filename)
        counter[extension] += 1

for _, count in counter.items():
    print(f"{_:8}{count}")


with open(f'{os.getcwd()}/sys-module.py', mode='+') as f:
    file = f.read()
    print(file)

with open('/home/marshall/message.txt', mode='a') as f:
    print('Hit \'q\' to exit...')
    while True:
        message = str(input('Enter line: ').strip())

        if message == 'q':
            print()
            break

        f.write(f'{message}\n')

with open('/home/marshall/message.txt', mode='r') as f:
    print(f.read(), end='')
"""

# Get the statistics information about a given file

file = '/home/marshall/message.txt'
st = os.stat(file)

print(f'Stats for file {file}')
mode, inode, dev, nlink, uid, gid, size, atime, mtime, ctime = st
print(f'Owner: ...\n'
      f'Permissions: {oct(mode)}\n'
      f'Size: {size}\n'
      f'ctime: {time.ctime(ctime)} | atime: {time.ctime(atime)} | mtime: {time.ctime(mtime)}\n'
      f'dev: {dev}\n'
      f'nlink: {nlink}')