if (( $+commands[fzf] )); then
  export FZF_CTRL_T_COMMAND=''
  eval "$(fzf --zsh)"
fi