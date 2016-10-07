#!/usr/bin/env bash

# Set architecture flags
export ARCHFLAGS="-arch x86_64"

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export HISTFILESIZE=10000

# define PATH
export PATH=/usr/bin:/bin:/usr/sbin:/sbin
export PATH=/opt/X11/bin:$PATH
export PATH=/Library/TeX/texbin:$PATH
export PATH=/usr/local/pgsql/bin:$PATH
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH

export GDAL_DRIVER_PATH=/usr/local/lib/gdalplugins

export HOMEBREW_CASK_OPTS="--appdir=/Applications"


# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{aliases,functions,extra}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Highlight section titles in manual pages.
export LESS_TERMCAP_md="${yellow}";

# Don’t clear the screen after quitting a manual page.
export MANPAGER='less -X';

# Always enable colored `grep` output.
export GREP_OPTIONS='--color=auto';

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;