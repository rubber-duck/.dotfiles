# ===== Key Bindings =====

# History search with Up/Down (covers xterm, iTerm2, Terminal.app, Linux console)
bindkey '\e[A'                  history-beginning-search-backward   # Standard xterm
bindkey '\e[B'                  history-beginning-search-forward
bindkey '\eOA'                  history-beginning-search-backward   # Application mode (tmux, some Linux terms)
bindkey '\eOB'                  history-beginning-search-forward
bindkey '^[p'                   history-beginning-search-backward   # Alt+P/N fallback
bindkey '^[n'                   history-beginning-search-forward

# Word navigation (Option+Left/Right on macOS, Ctrl+Left/Right on Linux)
bindkey "[D"                    backward-word                       # macOS Option+Left in some terminals
bindkey "[C"                    forward-word
bindkey '\e[1;3D'               backward-word                       # Alt+Left (xterm/Ghostty)
bindkey '\e[1;3C'               forward-word
bindkey '\e[1;5D'               backward-word                       # Ctrl+Left (xterm/Ghostty/Linux)
bindkey '\e[1;5C'               forward-word
bindkey '\e[5D'                 backward-word                       # Ctrl+Left (some terminals)
bindkey '\e[5C'                 forward-word
bindkey '\eb'                   backward-word                       # Alt+B / tmux-normalized movement
bindkey '\ef'                   forward-word

# Word/line deletion used by QMK navigation layers and tmux/Ghostty normalization.
bindkey '^W'                    backward-kill-word
bindkey '\e[3;5~'               kill-word                           # Ctrl+Delete
bindkey '\e[3;3~'               kill-word                           # Alt+Delete
bindkey '\ed'                   kill-word                           # Alt+D / tmux-normalized delete word
bindkey '^U'                    backward-kill-line

# Menu navigation
bindkey '^[[Z'                  reverse-menu-complete               # Shift-Tab
