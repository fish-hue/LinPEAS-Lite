#!/bin/bash

# Function to display the main menu
function display_menu() {
    echo -e "\n\e[1mMenu\e[0m"
    echo "----"
    echo "1. Files with Known Credentials"
    echo "2. Processes Owned by Root"
    echo "3. SUID/SGID Binaries"
    echo "4. Exit"
}

# Function to display results by user
function display_results_by_user() {
    read -p "Enter the user name to display results: " user
    if [ ! -z "$user" ]; then
        echo ""
        echo -e "\e[1mResults for User: $user\e[0m"
        echo "------------------"
        grep -rIi --color=auto "password" /etc/ 2>/dev/null | grep ":$user" | cut -d: -f1 | sort -u
        ps -U $user -u $user u
        find / -type f \( -user $user -perm -04000 -o -user $user -perm -02000 \) -ls 2>/dev/null | awk '{print $3,$5,$11}' | sort -u
    fi
}

# Loop to display the menu until the user chooses to exit
while true; do
    display_menu
    read -p "Enter the option number: " choice
    echo ""
    case $choice in
        1)
            echo -e "\e[1mFiles with Known Credentials\e[0m"
            echo "----------------------------"
            echo "These files may contain credentials that can be used to escalate privileges:"
            echo ""
            grep -rIi --color=auto "password" /etc/ 2>/dev/null | cut -d: -f1 | sort -u
            grep -rIi --color=auto "password" /var/log/ 2>/dev/null | cut -d: -f1 | sort -u
            ;;
        2)
            echo -e "\e[1mProcesses Owned by Root\e[0m"
            echo "-----------------------"
            echo "These processes are owned by root and may be vulnerable to exploitation:"
            echo ""
            ps aux | awk '$1=="root" {print $0}'
            ;;
        3)
            echo -e "\e[1mSUID/SGID Binaries\e[0m"
            echo "------------------"
            echo "These binaries have special permissions and may be vulnerable to exploitation:"
            echo ""
            find / -type f \( -perm -04000 -o -perm -02000 \) -ls 2>/dev/null | awk '{print $3,$5,$11}' | sort -u
            ;;
        4)
            echo "Exiting the script."
            exit
            ;;
        *)
            echo "Invalid option. Please try again."
            ;;
    esac
    if [ $choice -ge 1 -a $choice -le 3 ]; then
        while true; do
            read -p "Do you want to see results by user? (y/n): " yn
            case $yn in
                [Yy]* )
                    display_results_by_user
                    break;;
                [Nn]* )
                    break;;
                * ) echo "Please answer yes or no.";;
            esac
        done
    fi
done
