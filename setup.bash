#!/bin/bash
#Some code from https://raw.githubusercontent.com/rust-lang/rustup/refs/heads/master/rustup-init.sh

salt_command="sudo salt-call --local --file-root ./ --pillar-root ./pillar/"

check_cmd() {
   	command -v "$1" > /dev/null 2>&1
}

check_file() {
	[[ -a /etc/os-release ]]
}

attached_to_terminal() {
	[[ -t 0 && -t 1 ]]
}

check_os() {
	case "$1 $2" in
		"Debian 11" | "Ubuntu 24.04") return 0;;
		*) return 1;
	esac
}

set -u

if ! attached_to_terminal; then
	echo "Shell is not attached to a terminal; exiting...";
	exit;
fi

if ! check_cmd salt-call; then
	echo "No salt-call, exiting...";
	exit;
fi

# if ! check_file /etc/os-release; then
# 	echo "/etc/os-release doesn't exist, exiting";
# 	exit;
# fi

# os_id=`cat /etc/os-release | grep "^ID=" | cut -d '=' -f 2`
# os_version_id=`cat /etc/os-release | grep "^VERSION_ID=" | cut -d '=' -f 2 | tr -d \"`

os_id=`$salt_command grains.get os | tail -n 1 | xargs`
os_version_id=`$salt_command grains.get osrelease | tail -n 1 | xargs`
target_user=`$salt_command pillar.get target_user | tail -n 1 | xargs`
target_group=`$salt_command pillar.get target_group | tail -n 1 | xargs`

if ! check_os $os_id $os_version_id; then
	echo "Unsupported OS: $os_id $os_version_id. Exiting..."
	exit;
fi

echo "-----------"
echo "Detected OS: $os_id"
echo "Detected OS Version: $os_version_id"
echo "Target User: $target_user"
echo "Target Group: $target_group"
echo "-----------"
echo -n "Is this correct? [y/N] "
read proceed_confirmation
if [[ $proceed_confirmation != "y" && $proceed_confirmation != "Y" ]]; then
	echo "Options not confirmed, exiting";
	exit;
fi

#Execute salt command with options provided
$salt_command state.apply
