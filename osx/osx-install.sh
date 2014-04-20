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
brew bundle Brewfile

# Refresh Quicklook with newly installed plugins
qlmanage -r

# Install ruby versions!
ruby-build 1.9.3-p448
ruby-build 2.0.0-p247
rbenv global 2.0.0-p247
