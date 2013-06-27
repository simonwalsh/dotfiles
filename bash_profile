#############
#  General  #
#############
# bash complettion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi



############
#  Colors  #
############
bldgrn='\e[1;32m' # bold green
txtrst='\e[0m'    # text reset
blue='\033[0;34m' # non bold blue
red='\e[1;31m'    # red
purple='\e[1;35m' # purple



################
#  Prompt Mod  #
################
# git hotness
parse_git_deleted(){
   [[ $(git status 2> /dev/null | grep deleted:) != "" ]] && echo "-"
}
parse_git_added(){
   [[ $(git status 2> /dev/null | grep "Untracked files:") != "" ]] && echo "+"
}
parse_git_modified(){
   [[ $(git status 2> /dev/null | grep modified:) != "" ]] && echo "*"
}
parse_git_dirty(){
   echo "$(parse_git_added)$(parse_git_modified)$(parse_git_deleted)"
}
parse_git_branch(){
   git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}

prompt_command(){
   printf "\n$bldgrn%s$blue@${HOSTNAME}$bldgrn %s $purple$(parse_git_branch)\n$txtrst" "$USER" "$PWD"
}
PROMPT_COMMAND=prompt_command
PS1='->'



############
#  LS Mod  #
############
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxexexaxaxaxax



#############
#  Aliases  #
#############

alias tmux='TERM=xterm-256color tmux'

alias ios='/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Applications/iPhone\ Simulator.app/Contents/MacOS/iPhone\ Simulator'



### WordPress downloads ###
# Download latest stable release of WP into the current directory
# Also get the starkers theme
getwp(){
  # first parameter is the name of the directory we want WP in
  DIR=${1:-'wp'}
  if [ $DIR == 'wp' ]; then
    echo 'You did not pass any project name, using default'
  fi

  # we have a project name, create a directory and move into it
  mkdir $DIR
  cd $DIR

  # if we receive a version number use it else use the trunk
  VER=${2:-'trunk'}
  if [ $VER == 'trunk' ]; then
    svn co http://core.svn.wordpress.org/trunk/ .
  else
    svn co http://core.svn.wordpress.org/tags/$VER/ .
  fi

  # bring in the starkers theme
  cd wp-content/themes
  git clone git://github.com/viewportindustries/starkers.git
  cd ../../

  # rename wp-config-sample.php to wp-config.php
  mv wp-config-sample.php wp-config.php

  # bring in the 5G Blacklist
  cp ~/Dropbox/dotfiles/htaccess .htaccess

  # and open it in MacVim
  mvim wp-config.php

  # and open the directory
  open .
}



# Connect to IRCii as nddery
alias irc='irc nddery chat.freenode.net'



### GIT ###
# Git Completion
# source ~/Dropbox/git-completion.bash

# Aliases for git
alias gs='git status'
alias gc='git commit'
alias ga='git add'
alias gb='git branch'
alias gch='git checkout'
# better logging
alias gl='git log --pretty=format:"%C(yellow)%h %C(blue)%ad%C(red)%d %C(reset)%s%C(green) [%cn]" --decorate --date=short'
# what have I done yesterday
alias yesterday="git log --since '1 day ago' --oneline --author nddery@gmail.com"



### VIM ###
# Start VIM in "encrypted" mode
alias vimenc="vim -u ~/.vimrc.encrypted -x"

# Update SPF13-VIM-3
alias updateVim="curl http://j.mp/spf13-vim3 -L -o - | sh"


### TYPOS ###
alias gti='git'



## ANDROID ##
# Start the specified emulator #
# startEmulator galaxyNexus 0.4 false
function startEmulator()
{

  # if the second parameter is not set, defaults to true (load the snapshot)
  LOAD=${2:-'true'}

   # ifthe third parameter is not set, defaults to 1.0 (set scale to full)
  SCALE=${3:-'1.0'}

  # initialize so it does not run '-no-snapshot-load'
  SNAPSHOT=''
  if [ $LOAD == 'false' ]
    then
       SNAPSHOT='-no-snapshot-load'
  fi

  echo "/Android/Android-sdk-mac_86/tools/emulator-arm -avd $1 -scale $SCALE "$SNAPSHOT 
  /Android/Android-sdk-mac_86/tools/emulator-arm -avd $1 -scale $SCALE $SNAPSHOT

}

# # Start the ICS android emulator
# alias ="/Android/Android-sdk-mac_86/tools/emulator-arm -avd ics"
# # Start the HoneyComb android emulator
# alias honeycomb="/Android/Android-sdk-mac_86/tools/emulator-arm -avd honeycomb"



# empty all VIM backup/swap/views directory (for when there's some problem
# with arrow keys and...)
function cleanVIM()
{

  # -R option is for recursive
  # -f option is to attempt to remove file without prompting (forceful)

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


# Force empty the trash (not securely)
function emptyTrash() {
  rm -rf ~/.Trash/*
}


################
# CSS Minifier #
################
# Pass in the style name and have a drink
function minify()
{
  curl -X POST -s --data-urlencode "input@$1" http://www.cssminifier.com/raw > ${1%.css}.min.css
}

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# if [[ "$TERM" != "screen-256color" ]]; then
#   exec tmux
# fi
