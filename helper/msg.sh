#!/usr/bin/env bash

# Message prefix.
_msg_prefix () {
  echo "[$(date -u '+%m-%d %H:%M:%S %Z')]<$(hostname)>:"
}

# Report a message.
msg () {
  echo "$(_msg_prefix)MSG: $*" >&2
}

# Verbose-debug message.
dbg () {
  echo "$(_msg_prefix)DBG: $*" >&2
}

# True if this shell is interactive.
_is_interactive () {
  case $- in
    *i*) return 0 ;;
    *)   return 1 ;;
  esac
}

# Report an error and terminate the script.
err () {
  echo "$(_msg_prefix)ERR: $*" >&2
  # Print call stack.
  local depth=${#FUNCNAME[@]}
  msg ========== backtrace: $depth ==========
  for (( i = 0; i < depth; i++)) ; do
    msg $i: ${FUNCNAME[$i]}
  done
  # Exit when it is not running from login shell.
  _is_interactive || exit 1
  # Just return error code if running from shell.
  return 1
}

# 'pretty' display (intended for script name)
banner () {
  BANNER_LINE="## [$*] ##"
  BANNER_BLEN=${#BANNER_LINE}
  BANNER_HEAD=$(printf '%0.s#' $(seq 1 $BANNER_BLEN))
  msg $BANNER_HEAD
  msg $BANNER_LINE
  msg $BANNER_HEAD
}

# Export functions.
export -f _is_interactive
export -f _msg_prefix 
export -f msg
export -f dbg
export -f err
export -f banner
