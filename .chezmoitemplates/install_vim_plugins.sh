
# Used to trigger an update when the Vim configuration file has changed
# dot_vimrc hash: {{ include "dot_vimrc" | sha256sum }}
# dot_vimrc.bundles hash: {{ include "dot_config/vim/vim.bundles" | sha256sum }}

# Setting up vim plug plugin for dependency management
if [ -e "$HOME"/.vim/autoload/plug.vim ]; then
  vim -E -s +PlugUpgrade +qa
else
  curl -fLo "$HOME"/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

vim -u "${XDG_CONFIG_HOME}/vim/vim.bundles" +PlugUpdate +PlugClean! +qa