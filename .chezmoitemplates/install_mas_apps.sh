
apps=(
    {{ range $package := .packages.mas }}
    "{{ $package }}"
    {{ end }}
)

if [[ $(command -v mas) ]]; then
    header "Installing Applications from mas"

    for app in "${apps[@]}"; do
        if mas list | awk '{print $1}' | grep -E "^${app}$" &>/dev/null; then
            continue
        fi
        mas install ${app}
    done
fi