# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ ! -z "${DISPLAY}" ]; then
  xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
fi

# Set explicit external solver location for opam installations
export OPAMEXTERNALSOLVER=/home/carm/local/bin/aspcud
# Add location of aspcud solver to path
export PATH=$PATH:/home/carm/local/bin
export ORACLE_HOME=/usr/lib/oracle/11.2/client64
export ORACLE_INCLUDE=/usr/include/oracle/11.2/client64


# OPAM configuration
. /home/carm/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
# Add location of opam binary
export LIBRARY_PATH=$LIBRARY_PATH:/home/carm/local/lib
# Add location of opam binary
export PATH=$PATH:/home/carm/local/bin
# Add location of opam lib root
export LIBRARY_PATH=$LIBRARY_PATH:/home/carm/local/lib
# Add location of opam lib root to LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/carm/local/lib
