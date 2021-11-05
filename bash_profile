#!/usr/bin/env bash

export EDITOR="/usr/local/bin/subl"

# Set architecture flags
export ARCHFLAGS="-arch x86_64"

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export HISTSIZE=10000
export HISTFILESIZE=20000

export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# define PATH
export PATH=/usr/bin:/bin:/usr/sbin:/sbin
export PATH=/opt/X11/bin:$PATH
export PATH=/Library/TeX/texbin:$PATH
# export PATH=/usr/local/pgsql/bin:$PATH
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export PATH=~/dev/github_com/dateh:$PATH
# export PATH=/usr/local/opt/gdal/bin:$PATH
export PATH=~/dev/gdal_python_tools:$PATH
# export PATH=/usr/local/opt/python/libexec/bin:$PATH
export PATH=/Applications/3DCityDB-Importer-Exporter/bin:$PATH
#export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH

# export GDAL_DRIVER_PATH=/usr/local/lib/gdalplugins
# export GDAL_DATA=dev/VirtualEnvs/monesca_p3/lib/python3.7/site-packages/rasterio/gdal_data
# export GRASS_PYTHON=/usr/local/bin/python2

export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_MAKE_JOBS=12
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
if type brew &>/dev/null
then
  HOMEBREW_PREFIX="$(brew --prefix)"
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]
  then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*
    do
      [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
    done
  fi
fi

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
