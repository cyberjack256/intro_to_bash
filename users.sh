#!/bin/bash

function create_user () {
    if (getent passwd "$1" > /dev/null ); # <- getent can interrogate databases (cat /etc/nsswitch.conf)
    then
        echo "The user $1 already exists";
    else 
        echo "Now creating user $1";
        sudo useradd "$1";
    fi
}
function remove_user () {
    if (getent passwd "$1" > /dev/null ) ; # <- getent can interrogate databases (cat /etc/nsswitch.conf)
    then
        echo "User $1 exists, would you like to remove the user and their home directory and mail spool? [yes|no]" ;
        declare -l remove_name ;
        read -r remove_name ;
        if [[  "$remove_name" = "yes"  ]] ; 
        then
            sudo userdel --remove "$1";
        elif [[ "$remove_name" = "no" ]] ;
        then
            echo "Thats okay, I'm glad we checked with you first! User $1 is safe and not deleted." ;
            return 0 ;
        else
            echo "Invalid entry please try again" ;
            return 1 ;
        fi
    else
        echo "User $1 does not exist, maybe check the spelling?" ;
    fi
}

while true ; do
    clear
    echo "Choose 1 2 or 3"
    echo "1: Check if a user exists"
    echo "2: Add a user"
    echo "3: Del a user"
    echo "4: Quit"
    read -rsn1
    case "$REPLY" in
     1) echo "Who are you looking for?" && read -r n && getent passwd "$n";;
     2) echo "What is the name of the user?" && read -r o && create_user "$o" ;;
     3) echo "What is the name of the user?" && read -r p && remove_user "$p";;
     4) exit 0;;
    esac
    read -rn1 -p "Press any key"
done