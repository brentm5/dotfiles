# load custom executable functions
for function in $XDG_CONFIG_HOME/zsh/functions/*; do
  source $function
done
