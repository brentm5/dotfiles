# Check if fnox is installed
if (( $+commands[fnox] )); then
  eval "$(fnox activate zsh)"
fi