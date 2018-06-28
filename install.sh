[ -z "${SCRIPT_PATH}" ] && SCRIPT_PATH=$(readlink -f "$0")
DOTFILES_DIRECTORY=$(dirname $BASH_SOURCE)

# copy dotfiles to the correct places...
ln -sf $DOTFILES_DIRECTORY/zsh/zshrc $HOME/.zshrc
ln -sf $DOTFILES_DIRECTORY/zsh/zlogin $HOME/.zlogin
ln -sf $DOTFILES_DIRECTORY/zsh/zlogout $HOME/.zlogout
ln -sf $DOTFILES_DIRECTORY/zsh/zprofile $HOME/.zprofile

cp $DOTFILES_DIRECTORY/zsh/zshenv.example $DOTFILES_DIRECTORY/zsh/zshenv
ln -sf $DOTFILES_DIRECTORY/zsh/zshenv $HOME/.zshenv

ln -sf $DOTFILES_DIRECTORY/vim $HOME/.vim
ln -sf $DOTFILES_DIRECTORY/vim/vimrc $HOME/.vimrc
