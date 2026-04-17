#! /bin/sh
set -euo pipefail

if ! command -v ansible-playbook > /dev/null; then
  echo 'Installing Ansible'
  if [[ "$(uname)" == "Darwin" ]]; then
    # Mac
    if ! command -v brew > /dev/null; then
      echo 'Installing Homebrew'
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      # Add to PATH for Apple Silicon
      if [[ $(uname -m) == "arm64" ]]; then
          eval "$(/opt/homebrew/bin/brew shellenv)"
      fi
    fi

    brew install ansible
  else
    # Linux (assume Arch, no other distros in-use yet)
    sudo pacman -Syu ansible
  fi
else
  echo 'Ansible already installed'
fi

# TODO: Install Ansible and Python requirements

# TODO: Clone the dotfiles repo, to support downloading and running just the script.
ansible-playbook playbooks/site.yml --inventory inventories/host.yml --limit "$1"

