#!/bin/bash

# this will check given package is installed or not
function isInstalled() {
	which "$1" | grep -o "$1" > /dev/null &&  return 0 || return 1
}

function install() {
	if [ -f /etc/centos-release ] || [ -f /etc/redhat-release ] || [ -f /etc/oracle-release ] || [ -f /etc/system-release ];
	then
		sudo yum install -y "$1"
		return 0
	else
		echo "OS type not supported"
		return 1
	fi
}

function checker() {
	echo checking is "$1" installed?
	isInstalled "$1"
	if [ "$?" = "0" ];
	then
		echo "$1" installed.
		return 0
	else
		echo "$1" not installed. attmpting to install
		install "$1"
		if [ "$?" = "0" ];
		then
			echo "$1" installed.
			return 0
		else
			echo failed to install "$1"
			return 1
		fi
	fi
}

checker ansible
checker python
checker git
