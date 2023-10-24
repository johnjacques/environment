# -*-sh-*-

###########################################################################
#
# login
#
# Shell login.
#
###########################################################################

# Export all variables.
set -a

# Environment Directory
ENVIRONMENT=$HOME/environment

# Function to get the Linux Distro and Version
function getdv {
    if [ -f /etc/os-release ]; then
	# freedesktop.org and systemd
	. /etc/os-release
	DISTRO=$NAME
	VER=$VERSION_ID
    elif type lsb_release >/dev/null 2>&1; then
	# linuxbase.org
	DISTRO=$(lsb_release -si)
	VER=$(lsb_release -sr)
    else
	# Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
	DISTRO=$(uname -s)
	VER=$(uname -r)
    fi

    echo "$DISTRO:$VER"
}

# Path
ORIGINAL_PATH=$PATH

if [ "Linux" = `uname` ]
then
    DV=$(getdv)
    DISTRO=$(echo $DV | cut -d':' -f1)
    VER=$(echo $DV | cut -d':' -f2)

    if [ -d "$HOME/apps/$DISTRO/$VER" ]
    then
	MYAPPS=$HOME/apps/$DISTRO/$VER
	MYAPPSPATH=$MYAPPS/bin:$MYAPPS/usr/sbin
    else
	unset MYAPPSPATH
    fi
fi

if [ -d $HOME/bin ]
then
    PATH=$HOME/scripts:$HOME/bin
else
    PATH=$HOME/scripts
fi

if [ ! -z $MYAPPSPATH ]
then
    PATH=$PATH:$MYAPPSPATH
fi

PATH=$PATH:/usr/bin:/bin:/usr/sbin:/sbin

# Find the XFCE applications, if available...
ls -d /opt/xfce* >/dev/null 2>&1

if [ "$?" = "0" ]
    then
    XFCE=`ls -d /opt/xfce*`
    PATH=$PATH:$XFCE/bin
    MANPATH=`manpath`:$XFCE/share/man
fi

# Proxies (-us, -fm, -chain, or -jf are reasonable options...)
http_proxy=http://proxy-us.intel.com:911
HTTP_PROXY=$http_proxy
https_proxy=http://proxy-us.intel.com:912
HTTPS_PROXY=$https_proxy
ftp_proxy=http://proxy-us.intel.com:911
FTP_PROXY=$ftp_proxy
socks_proxy=http://proxy-us.intel.com:1080
SOCKS_PROXY=$socks_proxy
no_proxy=10.0.0.0/8,192.168.0.0/16,localhost,127.0.0.0/8,intel.com
NO_PROXY=$no_proxy

# For git...
export GIT_SSL_NO_VERIFY=true

# Errata
PAGER=less
EDITOR=vi
HISTCONTROL=ignoreboth:erasedups
HISTSIZE=5000
PRINTER=UNKNOWN
#TERM=vt100
CVSROOT=":pserver:jjacques@aus-cvs:/export/cvsroot/sw"
LSF_ENVDIR=/tools/lsfadm/conf

# Start out with the default environment.
Z_ENVIRONMENT=default

# Specify the environment file.
ENV=$ENVIRONMENT/environment

# Update history etc.
Z_LOGIN_SOURCED=true
if [ -n "$Z_SHELL_HISTORY" ]
then
	Z_SHELL_HISTORY="$Z_SHELL_HISTORY\nlogin,`date`,$0"
else
	Z_SHELL_HISTORY="login,`date`,$0"
fi

# Done exporting variables!
# If this is left on, bash will throw odd '_<command>: line N: syntax error...
set +a

# Source in the environment
source $ENV
source ~/.bashrc

# New environment setting added by Protex on Fri Apr 21 17:39:45 CDT 2023 1.
# The unmodified version of this file is saved in /home/jjacques/.bash_profile964504836.
# Do NOT modify these lines; they are used to uninstall.
PATH="/workspace/sw/jjacques/projects/protex/install/protexIP/bin:${PATH}"
export PATH
# End comments by InstallAnywhere on Fri Apr 21 17:39:45 CDT 2023 1.
