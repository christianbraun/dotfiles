#!/usr/bin/env bash

export EDITOR="/usr/local/bin/subl"

# Set architecture flags
export ARCHFLAGS="-arch x86_64"

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export HISTFILESIZE=10000

# define PATH
export PATH=/usr/bin:/bin:/usr/sbin:/sbin
export PATH=/opt/X11/bin:$PATH
export PATH=/Library/TeX/texbin:$PATH
# export PATH=/usr/local/pgsql/bin:$PATH
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export PATH=/usr/local/opt/gdal/bin:$PATH
# export PATH=/usr/local/opt/python/libexec/bin:$PATH

#export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH

# export GDAL_DRIVER_PATH=/usr/local/lib/gdalplugins

# export GRASS_PYTHON=/usr/local/bin/python2

export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_MAKE_JOBS=6
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{aliases,functions,extra}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Add tab completion for many Bash commands
# brew
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
#macports
# if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
# 	. /opt/local/etc/profile.d/bash_completion.sh
# fi


# Highlight section titles in manual pages.
export LESS_TERMCAP_md="${yellow}";

# Don’t clear the screen after quitting a manual page.
export MANPAGER='less -X';

# Always enable colored `grep` output.
export GREP_OPTIONS='--color=auto';

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

##
# Your previous /Users/cbraun/.bash_profile file was backed up as /Users/cbraun/.bash_profile.macports-saved_2020-01-30_at_09:21:38
##

# MacPorts Installer addition on 2020-01-30_at_09:21:38: adding an appropriate PATH variable for use with MacPorts.
# export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

