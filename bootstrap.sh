#! /bin/sh
set -euo pipefail

if ! command -v ansible-playbook >/dev/null; then
    echo 'Installing Ansible'
    if [[ "$(uname)" == "Darwin" ]]; then
        # Mac
        if ! command -v brew >/dev/null; then
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

echo 'Installing dependencies'
ansible-galaxy collection install -r requirements.yml

echo 'Select a purpose:'
echo '  1) personal'
echo '  2) work'
read -p 'Enter choice [1-2]: ' choice
case "$choice" in
    1) purpose="personal" ;;
    2) purpose="work" ;;
    *) echo "Invalid choice: $choice" && exit 1 ;;
esac
sudo mkdir -p /etc/ansible/facts.d
printf '{"purpose": "%s"}\n' "$purpose" | sudo tee /etc/ansible/facts.d/identity.fact > /dev/null

# TODO: Clone the dotfiles repo, to support downloading and running just the script.
ansible-playbook --diff playbooks/site.yml --ask-become-pass
