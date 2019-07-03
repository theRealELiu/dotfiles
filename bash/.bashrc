#! /bin/bash
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm-color|*-256color) color_prompt=yes;;
esac

if [ "$color_prompt" = yes ]; then
  PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
  PS1='\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
  xterm*|rxvt*)
    PS1="\\[\\e]0;\\u@\\h: \\w\\a\\]$PS1"
    ;;
  *)
    ;;
esac

# enable color support of ls and also add handy aliases
export LSCOLORS=gxfxcxdxbxegedabagacad

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
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

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

cdls() {
  SAVEIFS=$IFS;
  IFS=$(echo -en "\\n\\b");
  if [ ! "$1" ]; then
    cdls ~/;
  else
    cd "$1" || return;
    ls -lh;
  fi
  IFS=$SAVEIFS;
}
alias cd='cdls'

# for enable the ch in Emacs
alias emacszh="export LC_CTYPE=zh_CN.UTF-8;/usr/bin/emacs";
alias es="emacs -nw";

alias q='cd ..'
alias ,,='cd ../..'
alias ,,,='cd ../../..'
alias ,,,,='cd ../../../..'
alias ,,,,,='cd ../../../../..'
alias ,,,,,,='cd ../../../../../..'
alias ,,,,,,,='cd ../../../../../../..'
alias ,,,,,,,,='cd ../../../../../../../..'
alias ,,,,,,,,,='cd ../../../../../../../../..'
alias ,,,,,,,,,,='cd ../../../../../../../../../..'
alias q!='exit'
alias p='cd -'

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
case "$(uname)" in
  Darwin*)
    if [ -f /usr/local/Cellar/bash-completion/1.3_3/etc/profile.d/bash_completion.sh ]; then
      . /usr/local/Cellar/bash-completion/1.3_3/etc/profile.d/bash_completion.sh
    fi
    ;;
  Linux*)
    if ! shopt -oq posix; then
      if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
      elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
      fi
    fi
    ;;
  *)
    echo unknown uname ;;
esac


################### some useful scripts ###################
copy() {
  case "$(uname)" in
    Darwin*)
      pbcopy ;;
    Linux*)
      xsel -b ;;
    *)
      echo "unknown uname"
      ;;
  esac
}

c() {
  if [ $# -eq 0 ]; then
    tee >(content="$(cat)"; echo -n "$content" | copy)
  else
    "$@" | tee >(content="$(cat)"; echo -n "$content" | copy)
  fi
}

eval "$(opam config env)"

JAVA_8_HOME=$(/usr/libexec/java_home -v 1.8.0_162)
JAVA_9_HOME=$(/usr/libexec/java_home -v 9.0.1)

export JAVA_HOME=$JAVA_8_HOME
alias jdk8="export JAVA_HOME=$JAVA_8_HOME"
alias jdk9="export JAVA_HOME=$JAVA_9_HOME"
PATH=$PATH:$JAVA_HOME