# ===== POSIX/Bash login shell (loaded for sh/bash login shells) =====

SHELLDIR="$HOME/.shell"

case "$(uname -s)" in
  Darwin) . "$SHELLDIR/platform/darwin-env.sh" ;;
  Linux)  . "$SHELLDIR/platform/linux-env.sh" ;;
esac
