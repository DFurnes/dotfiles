# Basic
# -----
alias c="clear"


# File operations
# ---------------
alias l="ls -GFh"
alias ls="ls -GFh"
alias ll="ls -GFhl"

alias t="tree -L 2 -I node_modules"
alias tl="tree -I node_modules"

alias ...="cd ../.."
alias ....="cd ../../.."

loc() { find $1 -name $2 | xargs wc -l }

# Shortcuts
# ---------
alias http="http-server"
alias be="bundle exec"


# OS X
# ----
alias ql='qlmanage -p "$@" & > /dev/null'
alias oo="open ." # open current directory in OS X Finder
function port() { sudo lsof -i :$*; } # check what's running on this port
function trash() { mv $1 ~/.Trash } # move file to the trash

# Vim
# ---
# using bundled vim from MacVim
# open multiple vim files in tabs
alias vi="mvim -v -p"
alias vim="mvim -v -p"
alias mvim="mvim -p"


# Git & GitHub
# ------------
alias g="git"
alias gs="git status"
alias gst="git status -sb"
alias ga="git add"
alias gc="git commit"
alias gdiff="git diff"
alias gb="git branch"
alias gch="git checkout"
alias gcb="git checkout -b"
alias glg="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias glgg="git log"
alias gp="git push"
alias gpl="git pull"
alias gclean="git fetch --prune --all && git branch --merged dev | grep -v 'dev' | xargs git branch -d && git branch"
alias ghub="hub browse"
gpr() {
  hub browse -- compare/$(git-branch-current)
}
gpu() { git push --set-upstream origin $(git-branch-current) } 
gpuf() { git push --set-upstream origin $(git-branch-current) --force } 
gsync() { git fetch upstream && git checkout dev && git rebase upstream/dev && git push origin dev } 


# Vagrant
# -------
alias v="vagrant"
alias vst="vagrant status"
alias vup="vagrant up"
alias vsp="vagrant suspend"
alias vre="vagrant halt && vagrant reload"


# DoSomething.org
# ---------------
ds() { vagrant ssh -c "cd /var/www/vagrant && ds $*" }
drush() { v ssh -c "cd /var/www/vagrant/html && drush $*" }
nsync() {
  cd $HOME/Sites/neue
  grunt prod

  rm -rf $HOME/Sites/dosomething/lib/themes/dosomething/paraneue_dosomething/bower_components/neue
  mkdir $HOME/Sites/dosomething/lib/themes/dosomething/paraneue_dosomething/bower_components/neue
  cp -r dist/* $HOME/Sites/dosomething/lib/themes/dosomething/paraneue_dosomething/bower_components/neue

  cd -

  echo "\e[42m\e[30m ✓ Built dist package and copied into DS app."
}
nlink() {
  rm -rf $HOME/Sites/dosomething/lib/themes/dosomething/paraneue_dosomething/bower_components/neue
  ln -s $HOME/Sites/neue/dist $HOME/Sites/dosomething/lib/themes/dosomething/paraneue_dosomething/bower_components/neue

  echo "\e[44m\e[30m ✓ Symlinked dist output directory to DS app."
}


# Fun
# ---
alias nyan='telnet nyancat.dakko.us'
