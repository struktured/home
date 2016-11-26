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

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"
# Set explicit external solver location for opam installations
export OPAMEXTERNALSOLVER=/home/carm/local/bin/aspcud
# Add location of aspcud solver to path
export PATH=$PATH:/home/carm/local/bin

# OPAM configuration
. /home/carm/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
