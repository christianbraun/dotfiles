#!/usr/bin/env bash

export EDITOR="subl"

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
export PATH=/usr/local/opt/gdal2-python/bin:$PATH
export PATH=/usr/local/opt/python/libexec/bin:$PATH

#export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH

export GDAL_DRIVER_PATH=/usr/local/lib/gdalplugins

export GRASS_PYTHON=/usr/local/bin/python2

export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_MAKE_JOBS=6
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export HOMEBREW_GITHUB_API_TOKEN="92f2d0c9f7c2190623c4f169c15758d373aa6535"

HOMEBREW_GITHUB_API_TOKEN="cc103f352c7dccb844939425d75fc125ea01ef1d"

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{aliases,functions,extra}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Add tab completion for many Bash commands
#if which brew > /dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
#    source "$(brew --prefix)/share/bash-completion/bash_completion";
#elif [ -f /etc/bash_completion ]; then
#    source /etc/bash_completion;
#fi;

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# Highlight section titles in manual pages.
export LESS_TERMCAP_md="${yellow}";

# Don’t clear the screen after quitting a manual page.
export MANPAGER='less -X';

# Always enable colored `grep` output.
export GREP_OPTIONS='--color=auto';

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;
