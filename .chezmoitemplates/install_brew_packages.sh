
# The default packages to install with Brew
brew bundle --file=/dev/stdin <<EOF
{{ range .packages.brews -}}
brew {{ . | quote }}
{{ end -}}
{{ range .packages.casks -}}
cask {{ . | quote }}
{{ end -}}
EOF