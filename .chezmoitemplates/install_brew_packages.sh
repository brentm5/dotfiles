
# The default packages to install with Brew
# Filters packages based on scope and work_environment setting
brew bundle --file=/dev/stdin <<EOF
{{- range .packages.brews }}
{{- if or (eq .scope "common") (and (eq .scope "work") $.work_environment) (and (eq .scope "personal") (not $.work_environment)) }}
brew {{ .name | quote }}
{{- end }}
{{- end }}
{{- range .packages.casks }}
{{- if or (eq .scope "common") (and (eq .scope "work") $.work_environment) (and (eq .scope "personal") (not $.work_environment)) }}
cask {{ .name | quote }}
{{- end }}
{{- end }}
EOF