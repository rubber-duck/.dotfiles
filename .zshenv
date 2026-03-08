# ===== Zsh Environment (loaded for every zsh invocation) =====

SHELLDIR="$HOME/.shell"

case "$(uname -s)" in
  Darwin) source "$SHELLDIR/platform/darwin-env.sh" ;;
  Linux)  source "$SHELLDIR/platform/linux-env.sh" ;;
esac
