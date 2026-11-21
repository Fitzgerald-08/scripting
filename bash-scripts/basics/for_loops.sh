#!/bin/bash
shopt -s nullglob
set -euo pipefail

entry=1
path="/home/marshall/Documents"

echo "Finding files in: $path"
for f in $(ls $path)
do
    echo "$entry. $f"
    entry=$(( entry + 1))
done

arr=('/home/marshall/' '/home/marshall/.config/' '/home/marshall/Documents')
for item in "${arr[@]}"
do
    echo "Searching folders: $item"
done

for f in /home/marshall/Documents/*.pdf
do
    echo "File: $f"
done

echo
echo "=== List of users with a UID greater or equal to 1000 ==="
for usr in $(cut -d":" -f1 /etc/passwd)
do
    uid=$(id $usr | cut -d" " -f1 | grep -Eo "[0-9]{1,}")
    if (( $uid > 1000 ))
    then
	echo "$usr: $(id $usr)"
    fi
done

for file in /home/marshall/Documents/*; do
	if [ "$file" =~ *.pdf$ ]; then
		echo $file
	fi
done
