# ===== Tool Completions =====

# Starship prompt
eval "$(starship init zsh)"

# UV (Python)
if type uv &>/dev/null; then
  eval "$(uv generate-shell-completion zsh)"
fi
if type uvx &>/dev/null; then
  eval "$(uvx --generate-shell-completion zsh)"
fi

# Bun completions
[[ -s "$HOME/.bun/_bun" ]] && source "$HOME/.bun/_bun"

# .NET completions
_dotnet_zsh_complete() {
  local completions=("$(dotnet complete "$words")")
  reply=( "${(ps/\n/)completions}" )
}
if type dotnet &>/dev/null; then
  compctl -K _dotnet_zsh_complete dotnet
fi

# kubectl completions
if type kubectl &>/dev/null; then
  source <(kubectl completion zsh)
fi

# Git
autoload -Uz vcs_info
