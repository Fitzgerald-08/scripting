#!/bin/bash

# Already implemented
# [+] Detect if the user provided no arguments
# [+] Determine if the provided folder/file actually exists
# [+] Make a distinction between folders and files
# [+] Scan a whole directory and copy its contents

# To be implemented
# [~] Replace .bak file extension with tarballs
# [~] Finding duplicates

# Found difficulty trying to implement
# [!] Tell empty folder from non-empty
# [!] Manage hidden files

# Minor problems found
# [-] When creating tarballs, the "Removing leading / from member names" pops up

# The path to the directory where to search
# Validate the input of the user to avoid unexpected behaviors

input_path=$1
backup_dir=$HOME/backups

# If the number of arguments is equal to 0, meaning no path is given,
# print an error message and exit.
if [[ $# == 0 ]]
then
    printf "Provide at least one argument...\n"
    printf "\t[-] Folder/file name\n"
    exit 1
fi

# Now, if the path provieded does not exists, regardless of whether it's a file
# or a folder, print an error message.
if [ ! -e $input_path ]
then
    printf "The specified file does not exist\n"
    exit 1
else
    # After passing all tests, determine if the file is a regular file or
    # a folder

    # If it's a file print a message it is a file
    # (That's the functionality for now, more will be added).
    if [ -f $input_path ]
    then
        printf "File found: %s\n" $input_path
        printf "[+] Copying...\n"

        # Extract filename
        filename=$(echo $input_path | tr "/" "\n" | tail -n 1)

        # Get the date to append to the filename
        date_format=$(date +"%Y-%m-%e")
        tar -czvf "$backup_dir/$filename-$date_format.tar.gz" $input_path

        if [[ $? == 0 ]]; then
            printf "[*] The file has been copied successfully\n"
        else
            printf "[!] An error has occurred\n"
        fi
        exit
    # On the other hand, if it's a folder, scan the whole folder looking for files
    elif [ -d $input_path ]
    then
        echo $input_path
        date_format=$(date +"%Y-%m-%e")

        # Extract folder name
        folder_name=$(echo $input_path | tr "/" "\n" | tail -n 1)
        tar -czvf "$backup_dir/$folder_name-$date_format.tar.gz" $input_path
        exit
    fi
fi
