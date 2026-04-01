if which nvim > /dev/null 2> /dev/null; then
  export EDITOR=nvim
else
  export EDITOR=vim
fi

<<<<<<< HEAD
alias ls='ls --color=auto'
alias grep='grep --color=auto'

if which terraform > /dev/null 2> /dev/null; then
  alias tf=terraform
fi
if which kubectl > /dev/null 2> /dev/null; then
  alias k=kubectl
fi
=======
# NVM stuff
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
>>>>>>> 908ecd3 (Move aliases to global .aliases file)

# Set up fzf key bindings and fuzzy completion
if which fzf > /dev/null 2> /dev/null; then
  FZF_ALT_C_COMMAND= eval "$(fzf --bash)"
fi

eval "$(archetect completions bash)"

[ -f ~/.aliases ] && source ~/.aliases
source ~/.secrets
