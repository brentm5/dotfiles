
apps=(
{{- range $package := .packages.mas }}
{{- if or (eq $package.scope "common") (and (eq $package.scope "work") $.work_environment) (and (eq $package.scope "personal") (not $.work_environment)) }}
    "{{ $package.name }}"
{{- end }}
{{- end }}
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