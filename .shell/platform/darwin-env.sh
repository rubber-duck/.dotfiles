# ===== macOS PATH & Environment =====

# Homebrew
if [[ -d /opt/homebrew ]]; then
  export PATH="/opt/homebrew/bin:$PATH"
fi

# Rancher Desktop
if [[ -d "$HOME/.rd" ]]; then
  export PATH="$HOME/.rd/bin:$PATH"
fi

# 1Password SSH Agent
if [[ -S "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock" ]]; then
  export SSH_AUTH_SOCK="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
fi
