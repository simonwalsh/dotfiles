#!/usr/bin/env bash

source utils.sh

main() {
  if ! cmd_exists 'node'; then
    # Installs `n`, which in turn installs node latest version.
    # https://github.com/tj/n#installation
    curl -L http://git.io/n-install | N_PREFIX="/usr/local" bash
  fi

  print_result $? 'Node'
}

main
