#!/bin/bash

# The path to the directory where to search
# Validate the input of the user to avoid unexpected behaviors
input_path=$1
backup_dir=$HOME/backups/
backup_dir_contents=$HOME/backups/*

# If the path provided DOES NOT contain a / at the end
# add it and set it as the new value for the variable.
if [[ $# == 0 ]]
then
    echo "Provide at least the path or file name to backup"
    exit
fi

if [[ ! $input_path =~ /$ ]]
then
    # If the file is a directory, scan it and return every single
    # file stored in it.
    if [ -d $input_path ]
    then
        input_path="${input_path}/"
    # If it's a file, just create a backup copy of it and move
    # it to the backup folder.
    elif [ -f $input_path ]
    then
        # Extract the name of the file you wish to backup
        filename=$(ls $input_path | tr "/" "\n" | tail -n 1)
        # Add the .bak extension (Important to keep a distinction and referene it later)
        compose_filename="${filename}.bak"
        # Scan the directory backups to look for the file in question
        for f in $backup_dir_contents
        do
            if [[ $(find $backup_dir -name $compose_filename -type f) ]]
            then
                printf "File found in directory\n"
                read -p "Overwrite/exit [o/e]"
                exit
            else
                # If the find command found nothing, proceed to make the copy
                cp $input_path "$backup_dir$compose_filename"
                # If the status code of the previous operation was 0, print a message
                # showing it all went well, and an error message otherwise.
                if (( $? == 0 ))
                then
                    echo "[+] The file has been copied succesfully"
                    find $HOME/backups -name $compose_filename -type f
                    exit
                else
                    echo "[!] An error has occurred."
                    exit
                fi
            fi
        done
    fi
fi

# In case the path provided is the same as that of the one
# for backups, throw a message indicating so and exit.
if [[ $input_path =~ $backup_dir ]]
then
    echo "[!] Fatal."
    echo "Source and target directories are the same"
    echo "Exiting script..."
    exit 1
fi

# If the first validation passes, scan the whole directory
# and backup every single file to its dedicated backup folder
for f in ${input_path}*
do
    # If the file in quetion is a directory, skip this copy
    # and proceed with the next file.
    if [ -d $f ]
    then
        printf "[&] Skipping %s, is a directory\n" $f
        continue
    else
        # Copy every file in the same folder with a .bak extension
        cp "${f}" "${f}.bak"
        # Then move that .bak file to the backup folder
        mv "${f}.bak" "$backup_dir"
        printf "[+] File %s copied\n" $f
    fi
done
