#!/bin/bash

ip=$1
i=1

while (( $i < 4 ))
do
    octet=$(echo $ip | cut -d "." -f $i)

    if [ $octet -gt 255 ] || [ $octet -le 0 ]
    then
	echo "[!] Octet $octet is invalid"
	exit 1
    fi
    
    ((i++))
    if [ $i -eq 4 ]
    then
	echo "[+] The IP address has been validated"
    fi
done

printf "\n===============================\n"
printf "[*] Now scanning IP address..."
printf "\n===============================\n"
