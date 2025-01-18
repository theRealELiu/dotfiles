# Alias definitions.

case "$(uname)" in
  Darwin*)
    alias ls='ls -G'
    ;;
  Linux*)
    alias ls='ls --color=auto'
    ;;
  *)
    echo "unknown uname"
    ;;
esac

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias g='grep -Hnr'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# List all files after changing directory.
cdls() {
  cd "$@" && ls -lh
}
alias cd='cdls'

alias q='cd ..'
alias qq='cd ../..'
alias qqq='cd ../../..'
alias qqqq='cd ../../../..'
alias qqqqq='cd ../../../../..'
alias q!='exit'
alias p='cd -'

alias vif='vim $(fzf)'
alias vimf='vif'

alias mysudo='sudo -E env "PATH=$PATH"'
