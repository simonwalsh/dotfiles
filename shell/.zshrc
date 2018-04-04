# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="agnoster"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(gitfast zsh-syntax-highlighting osx brew z)

source $ZSH/oh-my-zsh.sh

# Force mkdir to create intermediate dirs
alias mkdir='mkdir -p'

# Stop auto correcting good commands!
alias vagrant='nocorrect vagrant'

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
alias gco='git checkout'
alias gl='git log --pretty=format:"%C(yellow)%h %C(blue)%ad%C(red)%d %C(reset)%s%C(green) [%cn]" --decorate --date=short'
alias yesterday="git log --since '1 day ago' --oneline --author nddery@gmail.com"

# Vim
# Start VIM in "encrypted" mode
alias vimenc="vim -u ~/.vimrc.encrypted -x"

# Update Brew packages (all)
alias bua="brew update --all && brew upgrade `brew outdated` && brew cleanup && brew cask cleanup"

# Let's go to nom!
alias nom='npm'

# exuberant ctags ftw
alias ctags="`brew --prefix`/bin/ctags"

# Remove those pesky .DS_Store files.
alias rmds="find . -name '*.DS_Store' -type f -delete"

# Install gems in the <cwd>/.bundle/ directory
alias bi="bundle install --path=.bundle"
alias be="bundle exec"

# Install casks in /Application instead of ~/Applications
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# Use homebrew rbenv
eval "$(rbenv init -)"

# boost ulimit
ulimit -S -n 2048

# https://github.com/garabik/grc#automatic-aliases
[[ -s "/etc/grc.zsh"  ]] && source /etc/grc.zsh

# fzf
[ -f ~/.fzf.zsh  ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Load .zshrc.local if available, overrides other settings.
[[ -r ~/.zshrc.local ]] && . ~/.zshrc.local

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

export EDITOR=code
export VISUAL=code
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/icu4c/sbin:$PATH"
[[ -n "$SSH_CLIENT" ]] || export DEFAULT_USER="simonwalsh"
