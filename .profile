# Homebrew Stuff
eval "$(/opt/homebrew/bin/brew shellenv)"

export PATH="$PATH:$HOME/bin:$HOME/.local/bin"
export PATH=$PATH:/opt/homebrew/opt/rustup/bin
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH=$PATH:/opt/homebrew/share/google-cloud-sdk/bin

export npm_config_prefix="$HOME/.local"

# Docker Desktop has a new location for the socket. This breaks tools that expect the default location.
export DOCKER_HOST=unix:///Users/alisamji/.docker/run/docker.sock

