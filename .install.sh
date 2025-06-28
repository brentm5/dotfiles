
# Install Dependencies here

# Ensure zsh
# Mise
# curl https://mise.run | sh
# Chezmoi
# mise use -g chezmoi@latest
# Homebrew
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# font-hack-nerd-font

if ! brew list | grep -iq font-hack-nerd-font ; then
  echo "font-hack-nerd-font not found, installing"
  brew install font-hack-nerd-font
fi
