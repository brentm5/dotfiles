# Dotfiles


Here are dotfiles that are based on chezmoi



## Keyboard Overrides

Custom Key remapping located at ~/Library/LaunchAgents/com.local.KeyRemapping.plist

Use https://hidutil-generator.netlify.app/ to generate a config


## Configuring Mack defaults

Located in macos-settings.yaml

https://macos-defaults.com/

defaults write com.apple.finder "AppleShowAllFiles" -bool "true" && killall Finder

defaults write com.apple.finder "ShowPathbar" -bool "true" && killall Finder

defaults write NSGlobalDomain com.apple.mouse.scaling -float "1.5"
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

defaults write com.apple.menuextra.clock "DateFormat" -string "\"EEE d MMM HH:mm:ss\""

defaults write com.apple.dock "mru-spaces" -bool "false" && killall Dock

defaults write com.apple.finder "FXEnableExtensionChangeWarning" -bool "false" && killall Finder

# Allow for repeat of keys in vscode
defaults write com.microsoft.VSCode "ApplePressAndHoldEnabled" -bool false