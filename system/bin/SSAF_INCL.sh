#!/system/bin/sh

NONE='\033[00m'
RED='\033[01;31m'
GREEN='\033[01;32m'
YELLOW='\033[01;33m'
PURPLE='\033[01;35m'
CYAN='\033[01;36m'
WHITE='\033[01;37m'
BOLD='\033[1m'
UNDERLINE='\033[4m'

CMD=/system/bin/cmd
SCRIPT_VERSION=1

ACTION=$1
if [ "$ACTION" = "version" ]; then
	echo $SCRIPT_VERSION;
	exit 0
fi

function CHECK_INTERNET()
{
	if ping -q -c 1 -W 1 8.8.8.8 >/dev/null; then
	  echo "IPv4 is up"
	else
	  echo "IPv4 is down"
	fi
}

function MOUNT_RW()
{
	if [ ! -f "/system/xbin/sysrw" ]; then
		mount -o rw,remount /system
	else
		/system/xbin/sysrw
	fi
}

function MOUNT_RO()
{
	if [ -f "/system/xbin/sysro" ]; then
		/system/xbin/sysro
	fi
}

function press_enter()
{
	echo -n "Press EnterKey to continue.";
	read enterKey
}

function check_root()
{
	clear;
	if [[ $(id -u) -ne 0 ]] ; then
		echo "This script requires root access to execute";
		echo "Type  su  first before  cfg";
		echo "";
		sleep 2
		press_enter
		exit 0
	fi
}