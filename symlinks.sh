#!/usr/bin/env bash

source 'utils.sh'

declare -a FILES_TO_SYMLINK=(
  'shell/tmux.conf'
  'shell/zshrc'

  'git/git_template'
  'git/gitconfig'
  'git/gitignore'

  'vim/vimrc.before.local'
  'vim/vimrc.bundles.local'
  'vim/vimrc.encrypted'
  'vim/vimrc.local'
  'vim/xvimrc'
)

main() {
  local i=''
  local sourceFile=''
  local targetFile=''

  for i in ${FILES_TO_SYMLINK[@]}; do
    sourceFile="$(pwd)/$i"
    targetFile="$HOME/.$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")"

    if [ ! -e "$targetFile" ]; then
      execute "ln -fs $sourceFile $targetFile" "$targetFile → $sourceFile"
    elif [ "$(readlink "$targetFile")" == "$sourceFile" ]; then
      print_success "$targetFile → $sourceFile"
    else
      ask_for_confirmation "'$targetFile' already exists, do you want to overwrite it?"
      if answer_is_yes; then
        rm -rf "$targetFile"
        execute "ln -fs $sourceFile $targetFile" "$targetFile → $sourceFile"
      else
        print_error "$targetFile → $sourceFile"
      fi
    fi
  done
}

main
