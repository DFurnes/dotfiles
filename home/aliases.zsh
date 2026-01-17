# Basic
# -----

# Better built-ins:
if [ -x "$(command -v bat)" ]; then
  alias cat="bat"
fi

function yt-mp3() {
  yt-dlp -x --audio-format mp3 "$@"
}

alias rebuild="~/.dotfiles/rebuild"

# Clear screen and scroll-back, with a fun function name. :)
# <http://apple.stackexchange.com/a/113168>
function ✧() {
  command clear && printf '\e[3J'
}
alias clear="✧"
alias c="clear"

# macOS:
alias lock="pmset displaysleepnow"
alias flushdns="sudo killall -HUP mDNSResponder"

# Python:
alias venv="source venv/bin/activate"

# Jekyll:
alias j="bundle exec jekyll liveserve --incremental"

# File operations
# ---------------

# List files (with colors & file-type indicators (dir, symlink..))
alias l="ls -GFh"
alias ls="ls -GFh"

# Detailed file listing (with above options & human-readable file sizes)
alias ll="ls -GFhl"

# List directories, sorted by disk usage
alias lfs="du -sckx * | sort -nr"

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

# Get headers (using httpstat, if installed):
if [ -x "$(command -v httpstat)" ]; then
  alias headers="httpstat"
else
  alias headers="curl -svo /dev/null"
fi

function fheaders() { headers $* -H "Fastly-Debug: 1" }

# Shortcuts
# ---------

# NPM script shortcuts
alias s="npm start"
alias d="npm run dev"
alias t="npm test"

function chownme() { sudo chown -R $(whoami) $*}

# OS X
# ----
function oo() { open ${*:-"."} }
function port() { sudo lsof -i :$*; } # check what's running on this port
function trash() { mv $1 ~/.Trash } # move file to the trash

# Vim
# ---
if [ -x "$(command -v nvim)" ]; then
  alias vi="nvim"
  alias vim="nvim"
fi

if [ -f "/Applications/MacVim.app/Contents/MacOS/Vim" ]; then
  alias mvim="/Applications/MacVim.app/Contents/MacOS/Vim -g"
fi

# Git & GitHub
# ------------

git-branch-current() {
  git rev-parse --abbrev-ref HEAD
}

if [ -x "$(command -v hub)" ]; then
  alias git="hub"
  alias ci="hub ci-status --color -v | sed 's/?.*$//g'"
fi
alias g="git"
alias gs="git status"
alias gst="git stash"
alias ga="git add"
alias gc="git commit"
alias gdiff="git diff"
alias gb="git branch"
alias gch="git checkout"
alias gcb="git checkout -b"
alias gl="git log --pretty=format:'%Cred%h%Creset %s %C(bold blue)<%an>%Creset' --abbrev-commit"
alias glg="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gp="git push"
alias gpl="git pull"
alias gcl="git clone"
alias gcp="git cherry-pick"
alias gd="github"
function gpr() { hub compare $(git-branch-current) }
function gpu() { git push --set-upstream origin $(git-branch-current) } 
function gpuf() { git push --set-upstream origin $(git-branch-current) --force } 
