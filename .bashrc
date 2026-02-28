if which nvim > /dev/null 2> /dev/null; then
  export EDITOR=nvim
else
  export EDITOR=vim
fi


# Set up fzf key bindings and fuzzy completion
if which fzf > /dev/null 2> /dev/null; then
  FZF_ALT_C_COMMAND= eval "$(fzf --bash)"
fi

eval "$(archetect completions bash)"

[ -f ~/.aliases ] && source ~/.aliases
source ~/.secrets
