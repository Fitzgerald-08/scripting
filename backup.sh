#!/bin/bash

# The path to the directory where to search
# Validate the input of the user to avoid unexpected behaviors
path=$1
backup_dir=$HOME/backups/
backup_dir_contents=$HOME/backups/*.bak

# If the path provided DOES NOT contain a / at the end
# add it and set it as the new value for the variable.
if [[ ! $path =~ /$ ]]
then
    # If the file is a directory, scan it and return every single
    # file stored in it.
    if [ -d $path ]
    then
        path="${path}/"
    # If it's a file, just create a backup copy of it and move
    # it to the backup folder.
    elif [ -f $path ]
    then
        # Extract the of the file you wish to backup
        filename=$(ls $path | tr "/" "\n" | tail -n 1)
        # Add the .bak extension (Important to keep a distinction and referene it later)
        compose_filename="${filename}.bak"
        # Scan the directory backups to look for the file in question
        for f in $backup_dir_contents
        do
            # Obtain every single filename in the backups folder and store it in a variable
            backup_filename=$(ls $f | tr "/" "\n" | tail -n 1)
            # If at some point in the loop, the compose_filename (the original filename with
            # the .bak extension added) is equal that in the backups folder, print a message
            # showing it and exit.
            if [[ $compose_filename == $backup_filename ]]
            then
                printf "The file << %s >> already exists in the backup folder\n" $filename
                printf "%s\n" $f
                exit
            fi
        done
        # If the above condition was never met, that means the file was not found
        # in the backup folder, so the script can proceed with its operation
        
        # Copy a the desired file to the same folder with the .bak extension
        cp $path "${path}.bak"
        # Then move it to the backup directory
        mv "${path}.bak" $backup_dir
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
fi

# In case the path provided is the same as that of the one
# for backups, throw a message indicating so and exit.
if [[ $path = $backup_dir ]]
then
    echo "[!] Fatal."
    echo "Source and target directories are the same"
    echo "Exiting script..."
    exit 1
fi

# If the first validation passes, scan the whole directory
# and backup every single file to its dedicated backup folder
for f in "${path}*"
do
    # If the file in quetion is a directory, skip this copy
    # and proceed with the next file.
    if [ -d $f ]
    then
        printf "\t[#] Skipping %s, is a directory\n" $path
        continue
    else
        # Copy every file in the same folder with a .bak extension
        cp "${f}" "${f}.bak"
        # Then move that .bak file to the backup folder
        mv "${f}.bak" "$backup_dir"
        printf "[+] File %s copied\n" $f
    fi
done
