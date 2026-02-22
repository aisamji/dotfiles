if which nvim > /dev/null 2> /dev/null; then
  export EDITOR=nvim
else
  export EDITOR=vim
fi

alias ls='ls --color=auto'
alias grep='grep --color=auto'

if which terraform > /dev/null 2> /dev/null; then
  alias tf=terraform
fi
if which kubectl > /dev/null 2> /dev/null; then
  alias k=kubectl
fi

# Set up fzf key bindings and fuzzy completion
if which fzf > /dev/null 2> /dev/null; then
  FZF_ALT_C_COMMAND= eval "$(fzf --bash)"
fi

eval "$(archetect completions bash)"

alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

source ~/.secrets
