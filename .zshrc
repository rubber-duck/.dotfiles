# ===== Main zshrc =====
SHELLDIR="$HOME/.shell"

# Core
source "$SHELLDIR/completion.zsh"
source "$SHELLDIR/history.zsh"
source "$SHELLDIR/keybindings.zsh"
source "$SHELLDIR/aliases.zsh"
source "$SHELLDIR/tools.zsh"

# Platform-specific
case "$(uname -s)" in
  Darwin) source "$SHELLDIR/platform/darwin.zsh" ;;
  Linux)  source "$SHELLDIR/platform/linux.zsh" ;;
esac
export PATH="$HOME/.local/bin:$PATH"
