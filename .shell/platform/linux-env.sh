# ===== Linux PATH & Environment =====

# Tool paths (only add if installed)
[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"
[[ -d "$HOME/.dotnet/tools" ]] && export PATH="$HOME/.dotnet/tools:$PATH"
[[ -d "$HOME/.bun/bin" ]] && export PATH="$HOME/.bun/bin:$PATH"

# Node: Volta takes priority, falls back to system node
if [[ -d "$HOME/.volta" ]]; then
  export VOLTA_HOME="$HOME/.volta"
  export PATH="$VOLTA_HOME/bin:$PATH"
elif [[ -d /usr/local/lib/nodejs ]]; then
  export PATH="/usr/local/lib/nodejs/bin:$PATH"
fi
