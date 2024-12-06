#!/bin/bash
if ! [[ -a /etc/os-release ]]; then
	echo "/etc/os-release doesn't exist, exiting";
	exit;
fi
os_id=`cat /etc/os-release | grep "^ID=" | cut -d '=' -f 2`
os_version_id=`cat /etc/os-release | grep "^VERSION_ID=" | cut -d '=' -f 2 | tr -d \"`
target_user=`whoami`
target_group=$target_user

echo "-----------"
echo "Detected OS: $os_id"
echo "Detected OS Version: $os_version_id"
echo "Target User: $target_user"
echo "Target Group: $target_group"
echo "-----------"
echo -n "Is this correct? [y/N] "
read proceed_confirmation
if [[ $proceed_confirmation == "n" || $proceed_confirmation == "N" || $proceed_confirmation == "" ]]; then
	echo "Options not confirmed, exiting";
	exit;
fi
