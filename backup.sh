#!/bin/bash

# The path to the directory where to search
# Validate the input of the user to avoid unexpected behaviors
input_path=$1
backup_dir=$HOME/backups/
backup_dir_contents=$HOME/backups/*

# If the number of arguments is equal to 0, meaning no path is given,
# print an error message and exit.
if [[ $# == 0 ]]
then
    printf "Provide at least one argument...\n"
    printf "\t[-] Folder/file name\n"
    exit 1
fi

# Now, if the path provieded does not exits, regardless of whether it's a file
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
        printf "You have entered a file\n"
        exit
    # On the other hand, if it's a folder, scan the whole folder looking for files
    elif [ -d $input_path ]
    then
        for f in $input_path/*
        do
            # If one of the entries turns out to be a folder, skip it and continue
            # with the script.
            if [ -d $f ]
            then
                continue
            # If it's a regular file, follow a simple process to copy and rename the
            # copy in the backup folders.
            elif [ -f $f ]
            then
                # Extract file name
                filename=$(echo $f | tr "/" "\n" | tail -n 1)

                # Copy the file to the backups folder and add the .bak extension.
                cp $f "$HOME/backups/$filename.bak"
                printf "[+] File found: %s" $f

                # If this file is found in the backups folder, print a message
                # indicating it was copied successfully, and an error message otherwise.
                if find $backup_dir -name $filename -type f
                then
                    printf ", and copied\n"
                else
                    printf "\nThere was a problem copying the file\n"
                fi
            fi
        done
        exit
    fi
fi
