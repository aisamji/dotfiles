if which -s nvim; then
  export EDITOR=nvim
else
  export EDITOR=vim
fi

alias ls='ls --color=auto'
alias grep='grep --color=auto'

if which -s terraform; then
  alias tf=terraform
fi
if which -s kubectl; then
  alias k=kubectl
fi

# Set up fzf key bindings and fuzzy completion
if which -s fzf; then
  FZF_ALT_C_COMMAND= eval "$(fzf --bash)"
fi

eval "$(archetect completions bash)"

alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

source ~/.secrets
