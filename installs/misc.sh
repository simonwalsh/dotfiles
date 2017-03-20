#!/usr/bin/env bash

source utils.sh

main() {
  # Install tmux-vim-select-pane
  # https://gist.github.com/mislav/5189704
  if [ ! -f /usr/local/bin/tmux-vim-select-pane ]
  then
    execute "curl -fsSL https://raw.github.com/mislav/dotfiles/1500cd2/bin/tmux-vim-select-pane \
      -o /usr/local/bin/tmux-vim-select-pane \
      && chmod +x /usr/local/bin/tmux-vim-select-pane" "Installed tmux-vim-select-pane"
  fi
}

main
