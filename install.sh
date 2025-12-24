DOTFILES_DIRECTORY="$( cd "$(dirname "$0")" ; pwd -P )"

# copy dotfiles to the correct places...
ln -sf $DOTFILES_DIRECTORY/zsh/zshrc $HOME/.zshrc
ln -sf $DOTFILES_DIRECTORY/zsh/zlogin $HOME/.zlogin
ln -sf $DOTFILES_DIRECTORY/zsh/zlogout $HOME/.zlogout
ln -sf $DOTFILES_DIRECTORY/zsh/zprofile $HOME/.zprofile

cp $DOTFILES_DIRECTORY/zsh/zshenv.example $DOTFILES_DIRECTORY/zsh/zshenv
ln -sf $DOTFILES_DIRECTORY/zsh/zshenv $HOME/.zshenv

ln -hsF $DOTFILES_DIRECTORY/vim $HOME/.vim
ln -sf $DOTFILES_DIRECTORY/vim/vimrc $HOME/.vimrc

# Set up Vim directories:
mkdir ~/.vim/backups
mkdir ~/.vim/undodir


# Quiet the macOS "Last Login" message:
touch ~/.hushlogin
