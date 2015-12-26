#!/usr/bin/env bash

source '../utils.sh'

# package:options
declare -a PACKAGES=(
  # GNU core utilities (those that come with OS X are outdated)
  # Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
  'coreutils'
  'moreutils'
  # GNU `find`, `locate`, `updatedb`, and `xargs` are `g`-prefixed
  'findutils'
  # GNU `sed`, overwrites the built-in `sed`
  'gnu-sed:--default-names'

  # generic colouriser  http://kassiopeia.juls.savba.sk/~garabik/software/grc/
  'grc'

  'ack'
  'git'
  'gnupg'
  'htop-osx'
  'reattach-to-user-namespace'
  'tmux'
  'wget:--enable-iri'
  'zsh'

  'android-platform-tools'
  'ctags'
  'vim:--override-system-vi'
  'macvim:--override-system-vim'

  'composer'
  'mongodb'
  'mysql'
  'php54'
  'php54-mongo'

  'ffmpeg'
  'gifsicle'
)

main() {
  local i=''
  local -a parts=()
  local package=''

  execute "brew update --all" "Updated Homebrew"
  execute "brew upgrade `brew outdated`" "Upgraded outdated packages"

  brew_install "tap homebrew/dupes" "homebrew/dupes" "tap"
  brew_install "tap homebrew/versions" "homebrew/versions" "tap"
  brew_install "tap homebrew/homebrew-php" "homebrew/homebrew-php" "tap"

  for i in ${PACKAGES[@]}; do
    parts=(${i//:/ })
    package="${parts[0]}"

    if [ ${#parts[@]} -gt 1 ]; then
      package="$package ${parts[1]}"
    fi

    brew_install "${parts[0]}" "${package}"
  done

  execute "brew cleanup" "Removed outdated versions from the cellar"
}

main
