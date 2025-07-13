# load our own completion functions
fpath=(${XDG_CONFIG_HOME}/zsh/completion /usr/local/share/zsh/site-functions $fpath)

# completion
autoload -Uz compinit && compinit
