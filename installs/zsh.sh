#!/usr/bin/env bash

source utils.sh

main() {
  brew_install "zsh" "zsh"

  # Install oh-my-zsh
  cd ~
  if [ ! -d .oh-my-zsh ]
  then
    execute "sh -c '$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)'" "Cloned Oh My Zsh"

    if [ ! -f ~/.zshrc ]
    then
      execute "cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc" "Copied .zshrc template"
    fi
  fi

  # Install zsh-syntax-highlighting
  cd ~/.oh-my-zsh/custom/
  if [ ! -d plugins ]
  then
    execute "mkdir plugins" "Created plugins directory for Oh My Zsh"
  fi

  cd plugins

  if [ ! -d zsh-syntax-highlighting ]
  then
    execute "git clone git://github.com/zsh-users/zsh-syntax-highlighting.git" "Enabled Zsh syntax highlighting"
  fi

  # Change shell to zsh if not already like so
  if [ $(echo $SHELL) != '/bin/zsh' ]
  then
    execute "chsh -s /bin/zsh" "Changed login shell to Zsh"
  fi

  print_result $? 'Zsh + Oh My Zsh + Zsh Syntax Highlighting'
}

main
