# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="agnoster"
ZSH_THEME="ys"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Auto start tmux
ZSH_TMUX_AUTOSTART=false

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# plugins=(tmux gitfast vagrant zsh-syntax-highlighting osx npm brew forklift)
plugins=(tmux gitfast vagrant zsh-syntax-highlighting osx brew forklift)

source $ZSH/oh-my-zsh.sh

# # Uses MAMP PHP instead of system one.
# alias php='/Applications/MAMP/bin/php/php5.4.10/bin/php'

# Force mkdir to create intermediate dirs
alias mkdir='mkdir -p'

# Stop auto correcting good commands!
alias vagrant='nocorrect vagrant'

# Force tmux to work with 256 colors.
alias tmux='tmux -2'

# Archiving
alias tarbz2='tar -jcvf'
alias targz='tar -zcvf'
alias untarbz2='tar -jxvf'
alias untargz='tar -zxvf'

# Git
alias gti='git'
alias gs='git status'
alias gc='git commit'
alias ga='git add'
alias gb='git branch'
alias gch='git checkout'
# better logging
alias gl='git log --pretty=format:"%C(yellow)%h %C(blue)%ad%C(red)%d %C(reset)%s%C(green) [%cn]" --decorate --date=short'
# what have I done yesterday
alias yesterday="git log --since '1 day ago' --oneline --author nddery@gmail.com"

# Vim
# Start VIM in "encrypted" mode
alias vimenc="vim -u ~/.vimrc.encrypted -x"

# Update SPF13-VIM-3
alias updateVim="curl http://j.mp/spf13-vim3 -L -o - | sh"


# Dev functions - apache and mysql
function startdev() {
  startapache
  startmysql
}
  function startmysql() {
    mysql.server start
  }
  function startapache() {
    sudo apachectl start
  }

function stopdev() {
  stopapache
  stopmysql
}
  function stopmysql() {
    mysql.server stop
  }
  function stopapache() {
    sudo apachectl stop
  }

function restartdev() {
  restartapache
  restartmysql
}
  function restartmysql() {
    mysql.server restart
  }
  function restartartapache() {
    sudo apachectl restart
  }

function startmemcache() {
  memcached -m 8 -l 127.0.0.1 -p 11211 -d
}


# Use the existing VIM session if it exists
# Or fallback to normal mvim if no argument is passed
function mvim() {
  if [ -n "$1" ] ; then
    command mvim --remote-silent "$@"
  elif [ -n "$( command mvim --serverlist )" ] ; then
    command mvim --remote-send ":call foreground()<CR>:enew<CR>:<BS>"
  else
    command mvim
  fi
}


# empty all VIM backup/swap/views directory (for when there's some problem
# with arrow keys and...)
function cleanVIM() {
  # directories we'll empty are
  echo "Cleaning ~/.vimbackup/"
  rm -Rf ~/.vimbackup/*
  echo "Cleaning ~/.vimswap/"
  rm -Rf ~/.vimswap/*
  echo "Cleaning ~/.vimviews/"
  rm -Rf ~/.vimviews/*
  echo "Cleaning ~/.vimundo/"
  rm -Rf ~/.vimundo/*
  echo "All done!"
}


# Random function
# Pass in the style name and have a drink
function minify() {
  curl -X POST -s --data-urlencode "input@$1" http://www.cssminifier.com/raw > ${1%.css}.min.css
}


# Fix vagrant guest stuck at waiting for boot or waiting for graceful
# shutdown.
function forceVagrantShutdown() {
  # List available VMs
  VBoxManage list runningvms

  read -p "Which VM do you want to power off? " RESP

  VBoxManage controlvm $RESP poweroff

  echo "VM powered off. You shoud now be able run `vagrant up` sucessfully."
}

export PATH=/usr/local/share/python:$PATH
