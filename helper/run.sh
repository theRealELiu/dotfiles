#!/usr/bin/env bash

# Check if a function/alias/command is installed.
# installed [-q] <command>
# -q : no debug message will be printed.
installed () {
  if [ "$1" = "-q" ] ; then
    local quiet=true
    shift
  else
    local quiet=false
  fi
  if type $1 >/dev/null 2>&1 ; then
    $quiet || msg $1 is installed
    return 0
  else
    $quiet || msg $1 is not installed
    return 1
  fi
}

# run [-q] [-c] [command [args ...]]
# -q : no debug message will be printed.
# -c : eval '[command [args ...]]' instead of run them directly.
# -v : invert exit status.
run () {
  local need_eval=false
  local quiet=false
  local invert=false
  while [ "$1" = "-c" ] || [ "$1" = "-q" ] || [ "$1" = "-v" ] ; do
    case "$1" in
      "-c") need_eval=true ;;
      "-q") quiet=true ;;
      "-v") invert=true ;;
    esac
    shift
  done
  $quiet || dbg Running : "$@"
  if $need_eval ; then
    # Shellcheck warning: eval negates the benefit of arrays. Drop eval to preserve whitespace/symbols (or eval as string).
    # This the intended behavior, so that we can run commands with pipes and redirections.
    # shellcheck disable=SC2294
    eval "$@"
  else
    "$@"
  fi
  local err_num=$?
  if $invert; then
    err_num=$((! err_num))
  fi
  if [ $err_num -ne 0 ] ; then
    msg "Warning [$err_num] while doing [$*]"
  fi
  return $err_num
}

unset _fault_handler
push_fault_handler () {
  local num_handlers=${#_fault_handler[@]}
  _fault_handler[$num_handlers]="$*"
}

pop_fault_handler () {
  local num=${#_fault_handler[@]}
  if [ $num -gt 0 ] ; then
    local index=$((num - 1))
    echo ${_fault_handler[$index]}
    unset '_fault_handler[$index]'
  fi
}

# 'safe [command]' executes [command] and terminates if the exit code is
# nonzero. An alternative to "set -e"
safe () {
  run "$@"
  local err_num=$?
  if [ $err_num -ne 0 ] ; then
    local index=${#_fault_handler[@]}
    while [ $index -gt 0 ] ; do
      index=$((index - 1))
      local handler=${_fault_handler[$index]}
      msg "[$handler] will be executed due to Error [$err_num] while doing [$*]"
      $handler
    done
    unset _fault_handler
    err "Error [$err_num] while doing [$*]"
  fi
  return $err_num
}

# Export functions.
export -f installed
export -f run
export -f push_fault_handler
export -f pop_fault_handler
export -f safe

# Bash completion.
# Pick the exported functions that satify conditions below:
# 1, Defined in shell scripts just under 'helper' folder.
# 2, Function name not start with '_'.
# 3, Exclude function 'safe', 'run'.
# 4, One line can only have one exported function and it shoulld occupy the whole line.
_all_helper_functions(){
  local cur="${COMP_WORDS[$COMP_CWORD]}"
  if [ $COMP_CWORD -eq 1 ] ; then
    local helper_functions=$(grep -h -d skip -E '^[ ]*export -f ' $CI_HELPER/*.sh | sed 's/^[ ]*export -f //' |awk '{print $1}' | grep -v -w -E '(run|safe|^_.*)')
    COMPREPLY=($(compgen -W "$helper_functions" -- "$cur"));
  else
    local command="${COMP_WORDS[1]}"
    local compete_func=$(complete -p $command 2>/dev/null | awk '{print $5}')
    if [ -n "$compete_func" ]; then
      eval $compete_func
    else
      COMPREPLY=()
    fi
  fi
}

complete -o default -F _all_helper_functions run
complete -o default -F _all_helper_functions safe
