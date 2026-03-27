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

# Testing git worktree shortcut
gwt() {
  # Figure out branch name
  if [ -n "$1" ]; then
    BRANCH="$1"
  else
    BRANCHES=$(git for-each-ref --format='%(refname:short)' --exclude=refs/heads/main refs/heads)
    if which fzf > /dev/null 2> /dev/null; then
      BRANCH=$(echo "$BRANCHES" | fzf)
    else
      echo "$BRANCHES"
    fi
  fi

  if [ -z "$BRANCH" ]; then
    echo 'Pass in a branch name and rerun the command.' > /dev/stderr
    return 1
  fi

  # If branch does not exist, create the branch based off of origin/main
  if ! (git branch | grep -q $BRANCH); then
    git fetch
    git branch $BRANCH origin/main
  fi

  # create a worktree for it (if it does not exist), and cd to it.
  if [ ! -d ".gitworktrees/$BRANCH" ]; then
    git worktree add ".gitworktrees/$BRANCH" "$BRANCH"
  fi

  WORKTREE=$(git worktree list | grep "$BRANCH" | awk '{print $1}')
  if [ -n "WORKTREE" ]; then
    cd "$WORKTREE"
  fi
}

# TODO: Add command to destroy active worktree unless main one.

source ~/.secrets
