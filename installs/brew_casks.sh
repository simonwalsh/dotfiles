#!/usr/bin/env bash

source '../utils.sh'

# package:options
declare -a PACKAGES=(
  'firefox'
  'google-chrome'

  'disk-inventory-x'
  'dropbox'
  # screen dimming thing
  'flux'
  'limechat'
  'utorrent'
  'caffeine'

  'qlcolorcode'
  'qlimagesize'
  'qlmarkdown'
  'qlprettypatch'
  'qlstephen'
  'quicklook-csv'
  'quicklook-json'
)

main() {
  local i=''
  local -a parts=()
  local package=''

  execute "brew update --all" "Updated Homebrew"
  execute "brew upgrade `brew outdated`" "Upgraded outdated packages"

  if ! brew info brew-cask &>/dev/null; then
    brew_install "brew-cask" "caskroom/cask/brew-cask"
  else
    print_success "Installed the homebrew-cask tool"
  fi

  for i in ${PACKAGES[@]}; do
    parts=(${i//:/ })
    package="${parts[0]}"

    if [ ${#parts[@]} -gt 1 ]; then
      package="$package ${parts[1]}"
    fi

    brew_install "${parts[0]}" "${package}" "cask"
  done

  execute "brew cask cleanup" "Removed outdated versions from the cellar"
}

main