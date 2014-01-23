## OS X initial setup
# Installs some things I use to do work.

while true; do
    read -p "Have you installed XCode and the command line tools? y/n" yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer [y]es or [n]o.";;
    esac
done


read -p "Press any key to begin installing things...\n"


# Install Homebrew
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

# Install Homebrew packages
brew install hub # Github command line tool, used in some aliases
brew install imagemagick
brew install jp2a # JPEG to ASCII art, important productivity tool
brew install macvim # GUI for Vim
brew install node
brew install openssl 
brew install phantomjs
brew install pngcrush
brew install redis
brew install rename # allows renaming files based on regex
brew install tree # ls alternative that graphically shows file tree
brew install vim # upgrade to Vim 7.4
brew install webkit2png # take screenshots of websites
brew install wget # download things unix-style!
brew install yuicompressor # compress things!
brew install zsh # the best shell!

# Install rbenv and ruby-build
brew install rbenv
brew install ruby-build

ruby-build 1.9.3-p448
ruby-build 2.0.0-p247
rbenv global 2.0.0-p247

# Install Brew Cask
brew tap phinze/cask
brew install brew-cask

# Install QuickLook plugins for common filetypes
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json quicklook-csv
qlmanage -r
