# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal dotfiles repository managed by **chezmoi**, a dotfile manager that uses templates and data files to generate configuration files. The repository manages shell configurations (zsh), development tools via mise, custom scripts, and system settings for macOS.

## Chezmoi Commands

### Core Operations
```bash
# Apply changes to home directory (dry-run first recommended)
chezmoi diff                    # See what would change
chezmoi apply                   # Apply all dotfiles to home directory
chezmoi apply --verbose         # See what's being applied

# Add or update files
chezmoi add ~/.config/newfile   # Add a new file to dotfiles
chezmoi edit ~/.zshrc           # Edit the source file in dotfiles

# Re-run scripts
chezmoi init                    # Re-run initial setup scripts
chezmoi apply --force           # Force reapply everything

# Check status
chezmoi status                  # Show files that differ from source
chezmoi data                    # Show computed template data
```

### Working with Templates
Files with `.tmpl` extension are chezmoi templates that get processed. Template data comes from:
- `.chezmoi.toml.tmpl` - Main config with prompts and data definitions
- `.chezmoidata/` - YAML files with structured data (packages, SSH hosts)

### Script Execution Order
Scripts in `.chezmoiscripts/` run automatically:
- `run_before_*` - Runs before applying dotfiles
- `run_onchange_*` - Runs when the script content changes
- `run_after_*` - Runs after applying dotfiles

Key scripts:
- `run_before_10-install-pre-reqs.sh.tmpl` - Installs Homebrew, creates XDG directories, installs packages (only on first bootstrap)
- `run_onchange_050-brew-update-deps.sh.tmpl` - Updates Homebrew packages
- `run_onchange_060-mise-update-deps.sh.tmpl` - Updates mise-managed tools
- `run_onchange_070-vim-update-deps.sh.tmpl` - Updates vim plugins
- `run_onchange_080-mas-update-apps.sh.tmpl` - Updates Mac App Store apps

## Architecture

### Directory Structure
```
~/.dotfiles/
├── .chezmoi.toml.tmpl              # Main config with XDG paths, prompts
├── .chezmoidata/                   # Data files
│   ├── packages.yaml               # Homebrew packages, casks, mas apps
│   └── ssh_settings.yaml           # SSH hosts with 1Password references
├── .chezmoitemplates/              # Reusable template components
│   ├── base-shell-environment.sh   # XDG environment variables
│   ├── shell_utils.sh              # Colored output functions
│   └── install_*.sh                # Package installation templates
├── .chezmoiscripts/                # Auto-run scripts
├── dot_config/                     # Managed ~/.config files
│   ├── zsh/                        # ZSH configuration
│   │   ├── configs/                # Main config files
│   │   │   ├── pre/                # Load first
│   │   │   ├── *.zsh               # Load second
│   │   │   └── post/               # Load last
│   │   ├── functions/              # Custom shell functions
│   │   ├── completion/             # Shell completions
│   │   ├── plugins.zsh.tmpl        # ZSH plugin configuration
│   │   └── zshrc.tmpl              # Main zshrc with loader
│   ├── mise/config.toml            # Development tool versions
│   ├── gh/                         # GitHub CLI config
│   ├── vim/                        # Vim configuration
│   └── ...
├── dot_bin/                        # Custom scripts (executable_*)
└── dot_*.{file}                    # Root dotfiles (e.g., dot_gitconfig)
```

### ZSH Configuration System
The zshrc uses a three-stage loading system defined in `dot_config/zsh/zshrc.tmpl`:

1. **Pre-configs** (`configs/pre/`) - Load first (environment setup, paths)
2. **Main configs** (`configs/*.zsh`) - Core settings (editor, history, keybindings, options, prompt)
3. **Post-configs** (`configs/post/`) - Load last (tool initializations, completions)

Debug loading with environment variables:
```bash
ZSHRC_VERBOSE=true zsh      # Show which files are loading
ZSHRC_TIMING=true zsh       # Show timing for each file
ZSHRC_DEBUGGING=true zsh    # Enable both verbose and timing
```

### Environment Variables (XDG Spec)
All configurations follow XDG Base Directory specification, defined in `base-shell-environment.sh`:
- `XDG_CONFIG_HOME` - `~/.config`
- `XDG_DATA_HOME` - `~/.local/share`
- `XDG_STATE_HOME` - `~/.local/state`
- `XDG_CACHE_HOME` - `~/.cache`
- `USER_BIN_HOME` - `~/.local/bin`
- `CODE_HOME` - `~/code`
- `SECRETS_FILE` - `~/.secrets.local`

### Package Management
Two primary package managers:

**Homebrew** (system packages) - Defined in `.chezmoidata/packages.yaml`:
- `brews` - CLI tools (git, gnupg, docker, etc.)
- `casks` - GUI applications (fonts, raycast)
- `mas` - Mac App Store apps (Bear, Infuse)

**mise** (development tools) - Defined in `dot_config/mise/config.toml`:
- Language runtimes (node, python, ruby, rust, java, elixir)
- CLI tools (gh, kubectl, terraform, docker tools)
- Custom aliases for ubi/cargo/aqua packages

### Secret Management
Uses **fnox** for secret management with two providers:
- `keychain` - macOS Keychain for local secrets
- `1password` - 1Password vault integration

Configuration: `dot_fnox.toml` (manages `OP_SERVICE_ACCOUNT_TOKEN`)

Secrets are loaded via:
- `~/.config/zsh/secrets` - Always loaded secrets
- `~/.secrets.local` - Loaded with `load-secrets` function

### Custom Scripts
Located in `dot_bin/`, prefixed with `executable_`:
- Git helpers: `git-ca`, `git-create-branch`, `git-pr`, `git-repo`, `git-up`, etc.
- Utilities: `replace`, `tmux-spotify-info`

ZSH functions in `dot_config/zsh/functions/`:
- `load-secrets` - Load secrets from SECRETS_FILE
- `continuously` - Run command repeatedly
- `mcd` - Make directory and cd into it
- `git-delete-merged-branches` - Clean up merged git branches
- And many more...

## Common Workflows

### Adding a New Configuration File
```bash
# Add a new file from home directory
chezmoi add ~/.config/newapp/config.yaml

# If it needs templating, rename it
cd ~/.dotfiles
mv dot_config/newapp/config.yaml dot_config/newapp/config.yaml.tmpl
```

### Adding a New Tool via mise
```bash
# Edit mise config
chezmoi edit ~/.config/mise/config.toml

# Add tool under [tools] section
# Apply changes
chezmoi apply

# mise will automatically install on next shell load
```

### Adding a Homebrew Package
```bash
# Edit packages file
chezmoi edit-config-template
# Or directly: chezmoi edit ~/.dotfiles/.chezmoidata/packages.yaml

# Add to appropriate section (brews/casks/mas)
# Apply and run update script
chezmoi apply
```

### Adding a Custom Shell Function
```bash
# Create new function file
chezmoi edit ~/.config/zsh/functions/myfunction

# Function is automatically loaded by zsh on next shell start
```

### Testing Template Changes
```bash
# See what a template would generate
chezmoi cat ~/.zshrc

# Execute a template to see output
chezmoi execute-template < .chezmoi.toml.tmpl
```

## Important Files to Know

- `.chezmoi.toml.tmpl:1-11` - User prompts and data configuration
- `.chezmoi.toml.tmpl:13-32` - XDG and custom directory definitions
- `dot_config/zsh/zshrc.tmpl:12-123` - ZSH config loading system with debug support
- `.chezmoitemplates/shell_utils.sh` - Colored output functions (error, warning, notice, info, success, header)
- `dot_config/mise/config.toml:8-17` - Custom mise aliases for tools
- `.chezmoidata/ssh_settings.yaml` - SSH hosts configuration with 1Password integration

## macOS Specific

### System Defaults
Keyboard remapping is configured at:
`~/Library/LaunchAgents/com.local.KeyRemapping.plist`

Generate new configs: https://hidutil-generator.netlify.app/

macOS defaults reference: https://macos-defaults.com/

Common defaults commands are documented in README.md (Finder settings, mouse, dock, clock format).
