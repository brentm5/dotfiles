# Configures XDG specification environment variables.
# https://specifications.freedesktop.org/basedir-spec/latest/

# A single base directory relative to which user-specific data files should be written
export XDG_DATA_HOME={{ .xdgDataDir }}

# A single base directory relative to which user-specific configuration files should be written
export XDG_CONFIG_HOME={{ .xdgConfigDir }}

# A single base directory relative to which user-specific state data should be written
export XDG_STATE_HOME={{ .xdgStateDir }}

# A single base directory relative to which user-specific non-essential (cached) data should be written
export XDG_CACHE_HOME={{ .xdgCacheDir }}

# A single base directory relative to which user-specific bins should be written to have them included on the path
export USER_BIN_HOME={{ .userBinDir }}

# The directory code is stored on the host
export CODE_HOME={{ .userCodeDir }}

# The directory we sync with the cloud
export CLOUD_SYNC_HOME={{ .cloudSyncDir }}

# Configure Various applications to use XDG Specifications
# export ZDOTDIR="${XDG_CONFIG_HOME}"/zsh 
# export LESSHISTFILE="${XDG_STATE_HOME}"/less/history
# export GNUPGHOME="${XDG_DATA_HOME}"/gnupg