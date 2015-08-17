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
ENVIRONMENT=$HOME/bin/environment

# VirtualBox
VBOX_USER_HOME=$HOME/VirtualBox

# Crafty
CRAFTY_LOG_PATH=/home/john/.crafty
CRAFTY_RC_PATH=/home/john/.crafty
CRAFTY_TB_PATH=/library/chess/egtbs
CRAFTY_BOOK_PATH=/home/john/.crafty

# Path
ORIGINAL_PATH=$PATH
PATH=$HOME/bin\
:$ORIGINAL_PATH

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
