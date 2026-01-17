# Configure Vim mode:
set -o vi

# reduce delay on <ESC> to 0.1s
export KEYTIMEOUT=1

# keep backspace and ^h working even
# after returning from command mode
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char

# Use ^w to remove word backwards
bindkey '^w' backward-kill-word

# Use ^z to quickly switch between Vim and the terminal.
# <http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/>
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# start vim ctrlp from zsh
ctrlp() {
  zle reset-prompt
  if [ -x "$(command -v nvim)" ]; then
    </dev/tty nvim -c "Files!"
  else
    </dev/tty vim -c "Files!"
  fi
  zle send-break
}
zle -N ctrlp
bindkey "^p" ctrlp
