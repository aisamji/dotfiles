export PS1="\u@\h:\w\$ "
set -o ignoreeof

if which nvim > /dev/null 2> /dev/null; then
  export EDITOR=nvim
else
  export EDITOR=vim
fi


# NVM stuff
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Set up fzf key bindings and fuzzy completion
if which fzf > /dev/null 2> /dev/null; then
  FZF_ALT_C_COMMAND= eval "$(fzf --bash)"
fi

# Add alias for local plugin development with claude code.
alias claudep='claude --plugin-dir ~/orgs/p6m-run/claude-plugins/plugins/ybor-standards'

eval "$(archetect completions bash)"

[ -f ~/.aliases ] && source ~/.aliases

source ~/.secrets
