#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew tap 'homebrew/bundle'
brew tap 'homebrew/completions'
brew tap 'homebrew/core'
brew tap 'homebrew/fuse'
brew tap 'homebrew/python'
brew tap 'homebrew/science'
brew tap 'osgeo/osgeo4mac'

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade --all

# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names
# Install Bash 4.
brew install bash
brew tap homebrew/versions
brew install bash-completion2
# We installed the new shell, now we have to activate it
echo "Adding the newly installed shell to the list of allowed shells"
# Prompts for password
sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
# Change to the new shell, prompts for password
chsh -s /usr/local/bin/bash

# Install `wget` with IRI support.
brew install wget --with-iri
brew install wput

# Install Python
brew install python
brew install python3

# Install more recent versions of some OS X tools.
brew install vim --override-system-vi
brew install homebrew/dupes/grep
brew install homebrew/dupes/openssh
brew install homebrew/dupes/screen

# Install other useful binaries.
brew install htop
brew install git
brew install git-lfs
brew install git-flow
brew install git-extras
brew install imagemagick --with-webp
brew install speedtest_cli
brew install tree
brew install cowsay
brew install datamash
brew install mp3splt
brew install youtube-dl
brew install mas

# Install FOSS4G stack
brew install geos proj libkml
brew install hdf5 --with-mpi
brew install netcdf
brew install openblas --with-openmp
brew install r --with-openblas
brew install numpy
brew install matplotlib --with-cairo --with-tex
brew install scipy --with-openblas

brew install laszip
brew install liblas --with-laszip
brew install gdal --with-complete --with-opencl
brew install pdal --with-laszip
brew install gdal2  --with-complete --with-libkml --with-opencl --with-postgresql --with-python3 --with-qhull --with-unsupported
brew install grass7 --with--ffmpeg --with-liblas --with-netcdf --with-openblas --with-postgresql
brew install saga-gis --with-app --with-liblas --with-postgresql --with-python
brew install qgis2 --with-grass --with-r --with-saga-gis --without-server

# Install Cask
brew install caskroom/cask/brew-cask
brew tap caskroom/versions

# Core casks
brew cask install --appdir="~/Applications" xquartz
brew cask install --appdir="/Applications" shuttle
brew cask install --appdir="/Applications" spectacle

# Development tool casks
brew cask install --appdir="/Applications" github-desktop
brew cask install --appdir="/Applications" sublime-text2
brew cask install --appdir="/Applications" virtualbox
brew cask install --appdir="/Applications" pgadmin3
brew cask install --appdir="/Applications" pycharm-ce

# Misc casks
brew cask install --appdir="/Applications" chromium
brew cask install --appdir="/Applications" firefox
brew cask install --appdir="/Applications" adium
brew cask install --appdir="/Applications" skype

brew cask install yujitach-menumeters
brew cask install --appdir="/Applications" dropbox
brew cask install --appdir="/Applications" basictex

brew cask install --appdir="/Applications" hugin
brew cask install --appdir="/Applications" handbrake
brew cask install --appdir="/Applications" vlc
brew cask install --appdir="/Applications" libreoffice
#brew cask install --appdir="/Applications" gimp
#brew cask install --appdir="/Applications" inkscape

# Install developer friendly quick look plugins; see https://github.com/sindresorhus/quick-look-plugins
brew cask install gislook qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook suspicious-package

mas install 639968404 # Parcel
mas install 588726889 # ReadKit
mas install 412448059 # Forklift
mas install 430255202 # Mactracker
mas install 507257563 # Sip

# Remove outdated versions from the cellar.
brew cleanup
