# Basic
# -----

# Python
alias venv="source venv/bin/activate"

# Jekyll
alias j="bundle exec jekyll liveserve --incremental"

# Homestead
function homestead() {
  DIRECTORY=$(pwd)
  HOMESTEAD_DIRECTORY="$HOME/.homestead"
  HOME_RELATIVE_DIRECTORY=${DIRECTORY/$HOME/\~}
  DEFAULT="ssh --command \"cd $HOME_RELATIVE_DIRECTORY; bash\""
  (cd $HOMESTEAD_DIRECTORY; eval "vagrant ${*:-$DEFAULT}")
}

alias hs="homestead"

function art() {
  DIRECTORY=$(pwd)
  HOME_RELATIVE_DIRECTORY=${DIRECTORY/$HOME/\~}
  (cd ~/.homestead; eval "vagrant ssh --command \"cd $HOME_RELATIVE_DIRECTORY; php artisan ${*}\"")
}

# Clear screen and scroll-back
# <http://apple.stackexchange.com/a/113168>
alias clear="clear && PURER_PROMPT_COMMAND_COUNT=0 && printf '\e[3J'"
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
  bytes=$(cat $1 | wc -c)
  bytes_gz=$(gzip -c $1 | wc -c)
  bytes_per_kb="1024"

  echo "original size (kb): "
  echo "scale=2 ; $bytes / $bytes_per_kb" | bc

  echo "gzipped size (kb): "
  echo "scale=2 ; $bytes_gz / $bytes_per_kb" | bc
}

# Shortcuts
# ---------

alias hey="noglob hey"

# NPM script shortcuts
alias s="npm start"
alias t="npm test"

function chownme() { sudo chown -R $(whoami) $*}

# OS X
# ----
alias oo="open ." # open current directory in OS X Finder
function port() { sudo lsof -i :$*; } # check what's running on this port
function trash() { mv $1 ~/.Trash } # move file to the trash

# Vim
# ---
alias vi="nvim"
alias vim="nvim"
alias mvim="/Applications/MacVim.app/Contents/MacOS/Vim -g"

# Fuzzy-find ^P
fuzzy() {
  local files
  IFS=$'\n' files=($(fzf --multi --select-1 --exit-0 \
    --preview '[[ $(file --mime {}) =~ binary ]] &&
    echo {} is a binary file ||
    (highlight -O ansi -l {} ||
    coderay {} ||
    cat {}) 2> /dev/null | head -500'))
  if [[ -n "$files" ]]; then
    ${EDITOR:-vim} "${files[@]}"
  fi
}

# Git & GitHub
# ------------

git-branch-current() {
  git rev-parse --abbrev-ref HEAD
}

alias git="hub"
alias g="git"
alias gs="git status"
alias gst="git stash"
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
alias gh="hub browse"
function gpr() {
  hub compare $(git-branch-current)
}
function gpu() { git push --set-upstream origin $(git-branch-current) } 
function gpuf() { git push --set-upstream origin $(git-branch-current) --force } 
function gsync() { git fetch upstream && git checkout dev && git rebase upstream/dev && git push origin dev } 
function gsyncm() { git fetch upstream && git checkout master && git rebase upstream/master && git push origin master } 

alias gcapuf="git add . && git commit --amend --no-edit && gpuf"


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
