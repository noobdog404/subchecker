#!/bin/bash

red=`tput setaf 9` # red
green=`tput setaf 2` # Green
reset=`tput sgr0` # Text reset

# Logo of subchecker
logo() {
echo -e "${red}
               __         __              __ 
   _______  __/ /_  _____/ /_  ___  _____/ /_____  _____
  / ___/ / / / __ \/ ___/ __ \/ _ \/ ___/ //_/ _ \/ ___/
 (__  ) /_/ / /_/ / /__/ / / /  __/ /__/ ,< /  __/ /
/____/\__,_/_.___/\___/_/ /_/\___/\___/_/|_|\___/_/ 
${reset}\n\n
"
}
logo

# Basic Usage
usage="\nUsage:\t`basename $0` -l [domains.txt file] -o [default | output_file_name.txt] -t [time in seconds]

Options:\n -l text file containing list of domains
 -o name of the output file to store live domains. You can also use default paramter
 -v check the current version
 -t set the timeout (in seconds.)

Example: ./subchecker.sh -l domains.txt -o alive.txt
"

#Parsing the options
while getopts "hvi :l:o:t:" options
do
	case $options in
		h)
			# Print the usage
			echo -e "$usage"
			exit 0 
			;;
		v)	
			# Print the version of subchecker
			echo -e "version: 0.0.1"; exit 0 
			;;
		i)	
			# Print the information about subchecker
			echo -e "Take a list of domains and check weather its working or not"; 
			exit 0
			;;
		o)	
			# Store the filename in output paramter
			output=$OPTARG
			# If default is selected, than setting the default filename in output paramter
			if [ $output = "default" ]; then
				output="alive_subdomains.txt"
			else
				# checking if file already exist
				if [ -f "$output" ]; then
					# Prompt if users wants to override the output file or not
				   	read -p "Do you want to override the file [Y/n]: " override # Promting user to ask to override the file or not
				   	if [ $override = "n" ]; then
						# Read new file name because user does not want to override the output file
				   		read -p "Please enter a new text filename: " tmp
			   			output=$tmp
					else 
						rm $output
			   		fi
				fi
			fi
			;;
		t)
			# Set the timeout paramter
			timeout=$OPTARG
			# If default is selected than, setting the default timeout in timeout paramter
			if [ $timeout = "default" ]; then
				timeout=2
			fi
			;;
		l)	
			# Set name of the domains file in domains paramters
			domains=$OPTARG 
			;;
		*)	
			echo -e "$usage"
			exit 1 ;;
	esac
done

# If timeout paramter is not set than set the timeout parameter to default 
if [ -z "$timeout" ]; then
	timeout=2
fi

# If domain file is inputed by user than exit the program
if [ -z "$domains" ]; then
	echo -e "$usage"
	exit 0
else
	# Checking if the domain is live or not by pinging
	for target in $(cat $domains); do
		count=$( ping -c 1 -W $timeout $target | grep icmp* | wc -l )
		if [ $count -eq 0 ]
		then
			echo "${red}[-][FAIL]${reset}: $target"
		else	
			# If output file is not given by user than just print the result
			if [ -z "$output" ]; then
				echo "${green}[+][OK]${reset}  : $target"
			else
				# Store the output in output file
				echo "${green}[+][OK]${reset}  : $target"
				echo $target >> $output
			fi	
		fi
	done
fi

echo -e "\nFinished"
