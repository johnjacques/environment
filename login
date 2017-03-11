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
ENVIRONMENT=$HOME/.environment

# Path
ORIGINAL_PATH=$PATH
PATH=$HOME/bin\
:$ORIGINAL_PATH

# VirtualBox Home
VBOX_USER_HOME=/home/john/VirtualBox

# Crafty
CRAFTY_TB_PATH=/library/chess/egtbs
CRAFTY_LOG_PATH=/home/john/.crafty
CRAFTY_BOOK_PATH=/home/john/.crafty
CRAFTY_RC_PATH=/home/john/.crafty

# Avoid problems with older versions of IBus
IBUS_ENABLE_SYNC_MODE=1

# Handle ssh-agent/ssh-add automatically.

SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add >/dev/null 2>&1;
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent >/dev/null;
    }
else
    start_agent >/dev/null;
fi

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

# Source in the environment
source $ENV

cd $HOME
