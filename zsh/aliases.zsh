# Basic
# -----

# Better built-ins:
if [ -x "$(command -v bat)" ]; then
  alias cat="bat"
fi

# Clear screen and scroll-back, with a fun function name. :)
# <http://apple.stackexchange.com/a/113168>
function ✧() {
  command clear && PURER_PROMPT_COMMAND_COUNT=0 && printf '\e[3J'
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

# Homestead:
function homestead() {
  DIRECTORY=$(pwd)
  HOMESTEAD_DIRECTORY="$HOME/.homestead"
  HOME_RELATIVE_DIRECTORY=${DIRECTORY/$HOME/\~}
  DEFAULT="ssh --command \"cd $HOME_RELATIVE_DIRECTORY; /usr/bin/zsh\""
  (cd $HOMESTEAD_DIRECTORY; eval "vagrant ${*:-$DEFAULT}")
}

alias hs="homestead"


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

# Shortcuts
# ---------

alias hey="noglob hey"

# NPM script shortcuts
alias s="npm start"
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
  alias gh="hub browse"
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
alias glg="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gp="git push"
alias gpl="git pull"
alias gcl="git clone"
alias gd="github"
function gpr() { hub compare $(git-branch-current) }
function gpu() { git push --set-upstream origin $(git-branch-current) } 
function gpuf() { git push --set-upstream origin $(git-branch-current) --force } 

# Papertrail
# ----------

alias pt="papertrail"

# Download all logs matching a pattern.
# Usage: pt-archive <start date> <end date> <filter> <output>
# $ pt-archive 2018-12-01 2018-12-02 "dosomething-northstar" "ns-logs"
function pt-archive() {
  DIRECTORY=$(pwd)
  FILTER="${3:-\".*\"}"

  cd $(mktemp -d)

  echo "Downloading log archives from $1 to $2..."
  curl -sH "X-Papertrail-Token: $PAPERTRAIL_API_KEY" https://papertrailapp.com/api/v1/archives.json |
    grep -o '"filename":"[^"]*"' | egrep -o '[0-9-]+' |
    awk '$0 >= "'$1'" && $0 < "'$2'" {
      print "output " $0 ".tsv.gz"
      print "url https://papertrailapp.com/api/v1/archives/" $0 "/download"
    }' | curl --progress-bar -fLH "X-Papertrail-Token: $PAPERTRAIL_API_KEY" -K-


  echo "Unzipping compressed archives..."
  gunzip *.tsv.gz

  echo "Filtering by '$FILTER' & concatenating to one file..."
  cat *.tsv | grep -E $FILTER > $DIRECTORY/$4.tsv
  
  echo "Cleaning up..."
  rm *.tsv

  echo "All done! 🎊 $DIRECTORY/$4.tsv!"

  cd - > /dev/null
}

# See how effective a log filter would be on a given dump.
# Usage: log-filter <log_file> <filter>
function log-filter() {
  LOG_FILE=$1
  FILTER=$2

  LINES=$(grep $FILTER $LOG_FILE | wc -l)
  BYTES=$(grep $FILTER $LOG_FILE | wc -c)
  TOTAL_BYTES=$(cat $LOG_FILE | wc -c)

  echo "$LINES matching log lines"
  echo "$(($BYTES/1024/1024)) MB"
}

# DoSomething.org
# ---------------
alias ds-errors="papertrail --min-time '1 hour ago' -S 'All: Exceptions' | cut -f 4 -d ' ' | sort | uniq -c"

# Fun
# ---
alias pilogs="papertrail -c ~/.papertrail.dfurnes.yml"
