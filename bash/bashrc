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
HISTCONTROL=ignoreboth:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
# See https://www.shellhacks.com/tune-command-line-history-bash/
HISTSIZE=100000
HISTFILESIZE=200000

# Ignore specific commands
HISTIGNORE="ll:ll -*:ls:ls -*:q:cd:cd *:exit:vi"

# Save each command right after it has been executed.
PROMPT_COMMAND="history -a"

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

# Enable bash completion
[[ -s /etc/bash_completion ]] && source /etc/bash_completion

# Alias definitions.
[[ -s ~/.bash_aliases ]] && source ~/.bash_aliases

# Environment variable definitions.
[[ -s ~/.bash_envs ]] && source ~/.bash_envs

# fzf/install script will add this line to modify $PATH and set up shell
# integration. For more information, see: https://github.com/junegunn/fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
