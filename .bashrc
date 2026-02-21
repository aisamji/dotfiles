export EDITOR=nvim

# Set up fzf key bindings and fuzzy completion
FZF_ALT_C_COMMAND= eval "$(fzf --bash)"
eval "$(archetect completions bash)"

alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

source ~/.secrets
