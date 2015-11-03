#!/usr/bin/env bash
# Heavily inspired by https://github.com/alrra/dotfiles

source 'utils.sh'

ask_for_sudo

###

ask_for_confirmation 'Install/Update Xcode ?'
printf '\n'

if answer_is_yes; then
  print_info 'Install/Update Xcode'
  ./install/xcode.sh
  print_in_green '\n  ---\n\n'
fi

###

ask_for_confirmation 'Install/Update homebrew ?'
printf '\n'

if answer_is_yes; then
  print_info 'Install/Update homebrew'
  ./install/homebrew.sh
  print_in_green '\n  ---\n\n'
fi

###

ask_for_confirmation 'Install/Update node ?'
printf '\n'

if answer_is_yes; then
  print_info 'Install/Update node'
  ./install/node.sh
  print_in_green '\n  ---\n\n'
fi

###

ask_for_confirmation 'Install/Update Zsh ?'
printf '\n'

if answer_is_yes; then
  print_info 'Install/Update Zsh'
  ./install/zsh.sh
  print_in_green '\n  ---\n\n'
fi

###

ask_for_confirmation 'Install/Update brew packages ?'
printf '\n'

if answer_is_yes; then
  print_info 'Install/Update brew packages'
  ./install/brew_packages.sh
  print_in_green '\n  ---\n\n'
fi

###

ask_for_confirmation 'Install/Update brew casks ?'
printf '\n'

if answer_is_yes; then
  print_info 'Install/Update brew casks'
  ./install/brew_casks.sh
  print_in_green '\n  ---\n\n'
fi

###

ask_for_confirmation 'Install/Update misc ?'
printf '\n'

if answer_is_yes; then
  print_info 'Install/Update misc'
  ./install/misc.sh
  print_in_green '\n  ---\n\n'
fi

###

ask_for_confirmation 'Symlink dotfiles into place ?'
printf '\n'

if answer_is_yes; then
  print_info 'Symlink dotfiles into place'
  ./symlink-setup.sh
  print_in_green '\n  ---\n\n'
fi

###

ask_for_confirmation 'Update SPF-vim3 ?'
printf '\n'

if answer_is_yes; then
  execute "sh <(curl https://j.mp/spf13-vim3 -L)" "Updated SPF-vim3"
fi

###

print_success "Installation finished"
