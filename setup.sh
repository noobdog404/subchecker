#!/bin/bash

red=`tput setaf 9` # red
reset=`tput sgr0` # Text reset
logo() {
echo "${red}
 ___           _        _ _ _                         _          _               _ 
|_ _|_ __  ___| |_ __ _| | (_)_ __   __ _   ___ _   _| |__   ___| |__   ___  ___| | _____ _ __
 | || '_ \/ __| __/ _\` | | | | '_ \ / _\` | / __| | | | '_ \ / __| '_ \ / _ \/ __| |/ / _ \ '__|
 | || | | \__ \ || (_| | | | | | | | (_| | \__ \ |_| | |_) | (__| | | |  __/ (__|   <  __/ |
|___|_| |_|___/\__\__,_|_|_|_|_| |_|\__, | |___/\__,_|_.__/ \___|_| |_|\___|\___|_|\_\___|_|
                                    |___/
${reset}"
}
usage="
Usage: ./setup.sh -install

Options:
 -install 
     install subchecker
 -uninstall 
     uninstall subchecker
"

if [ "$1" = "-install" ]; then
	logo
	chmod 755 subchecker.sh
	if sudo cp subchecker.sh /usr/local/bin/subchecker; then
		echo "subchecker is installed"
	fi
elif [ "$1" = "-uninstall" ]; then
	echo "Unistall"
elif [ "$1" = "-h" ] || [ "$1" = "-help" ] || [ "$1" = "--help" ]; then
	logo
	echo "$usage"
else
	echo "Error" 
fi
