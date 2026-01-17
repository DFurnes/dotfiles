DOTFILES_DIRECTORY="$( cd "$(dirname "$0")" ; pwd -P )"

# Link dotfiles to the correct places...
ln -sf $DOTFILES_DIRECTORY/home/zshrc $HOME/.zshrc
ln -sf $DOTFILES_DIRECTORY/home/zprofile $HOME/.zprofile

ln -sf $DOTFILES_DIRECTORY/nvim/vimrc $HOME/.vimrc
ln -s ~/.dotfiles/nvim ~/.config/nvim

# Set up Vim directories:
mkdir -p ~/.vim/backups
mkdir -p ~/.vim/undodir