# Basic
# -----

# Homestead
function hs() {
  DIRECTORY=$(pwd)
  HOME_RELATIVE_DIRECTORY=${DIRECTORY/$HOME/\~}
  DEFAULT="ssh --command \"cd $HOME_RELATIVE_DIRECTORY; bash\""
  (cd ~/.homestead; eval "vagrant ${*:-$DEFAULT}")
}

# Clear screen and scroll-back
# <http://apple.stackexchange.com/a/113168>
alias clear="clear && printf '\e[3J'"
alias c="clear"

alias ws="pstorm"

alias lock="pmset displaysleepnow"

# File operations
# ---------------

# List files (with colors & file-type indicators (dir, symlink..))
alias l="ls -GFh"
alias ls="ls -GFh"

# Detailed file listing (with above options & human-readable file sizes)
alias ll="ls -GFhl"

# List directories, sorted by disk usage
alias lfs="du -sckx * | sort -nr"

# List files/directories in tree view
alias ts="tree -L 2 -I node_modules"
alias tl="tree -I node_modules"

# Directory traversal shortcuts
alias ...="cd ../.."
alias ....="cd ../../.."

# Get lines of code in a file
loc() { find $1 -name $2 | xargs wc -l }

# get gzipped size
function gz() {
  echo "orig size    (bytes): "
  cat "$1" | wc -c
  echo "gzipped size (bytes): "
  gzip -c "$1" | wc -c
}

# Shortcuts
# ---------

# Serve directory as a static site.
# Requires 'npm install -g http-server'
alias serve="http-server -o"

# NPM script shortcuts
alias s="npm start"
alias t="npm test"

# OS X
# ----
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

git-branch-current() {
  git rev-parse --abbrev-ref HEAD
}

alias git="hub"
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
alias glgp="git log --patch"
alias glgg="git log"
alias gp="git push"
alias gpl="git pull"
alias gcl="git clone"
alias gclean="git fetch --prune --all && git branch --merged dev | grep -v 'dev' | xargs git branch -d && git branch"
alias ghub="hub browse"
function gpr() {
  hub compare $(git-branch-current)
}
function gpu() { git push --set-upstream origin $(git-branch-current) } 
function gpuf() { git push --set-upstream origin $(git-branch-current) --force } 
function gsync() { git fetch upstream && git checkout dev && git rebase upstream/dev && git push origin dev } 
function gsyncm() { git fetch upstream && git checkout master && git rebase upstream/master && git push origin master } 


# Vagrant
# -------
alias v="vagrant"
alias vst="vagrant status"
alias vup="vagrant up"
alias vsp="vagrant suspend"
alias vre="vagrant halt && vagrant reload"


# DoSomething.org
# ---------------
ds() { vagrant ssh -c "cd /var/www/dev.dosomething.org&& ds $*" }
drush() { v ssh -c "cd /var/www/dev.dosomething.org/html && drush $*" }
alias dcc="drush cc all"

# Fun
# ---
alias nyan='telnet nyancat.dakko.us'

mp4togif() {
  ffmpeg -i $1 -vf scale=$2:-1 -r 10 -f image2pipe -vcodec ppm - | convert -delay 5 -loop 0 - output.gif
}
