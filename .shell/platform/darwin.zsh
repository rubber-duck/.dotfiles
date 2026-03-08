# ===== macOS-specific config =====

# PATH
source "${0:A:h}/darwin-env.sh"

# Homebrew completions
if [[ -d /opt/homebrew ]]; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
elif [[ -d /usr/local/Homebrew ]]; then
  FPATH="/usr/local/share/zsh/site-functions:${FPATH}"
fi

# Rancher Desktop completions
if [[ -d "$HOME/.rd" ]]; then
  [[ -f ~/.rd/completion.zsh ]] && source ~/.rd/completion.zsh
fi
