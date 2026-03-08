# ===== Key Bindings =====

# History search with Up/Down (covers xterm, iTerm2, Terminal.app, Linux console)
bindkey '\e[A'                  history-beginning-search-backward   # Standard xterm
bindkey '\e[B'                  history-beginning-search-forward
bindkey '\eOA'                  history-beginning-search-backward   # Application mode (tmux, some Linux terms)
bindkey '\eOB'                  history-beginning-search-forward
bindkey '^[p'                   history-beginning-search-backward   # Alt+P/N fallback
bindkey '^[n'                   history-beginning-search-forward

# Word navigation (Option+Left/Right on macOS, Alt+Left/Right on Linux)
bindkey "[D"                    backward-word
bindkey "[C"                    forward-word
bindkey '\e[1;3D'               backward-word                       # Alt+Left (xterm)
bindkey '\e[1;3C'               forward-word                        # Alt+Right (xterm)
bindkey '\eb'                   backward-word                       # Alt+B (standard emacs)
bindkey '\ef'                   forward-word                        # Alt+F (standard emacs)

# Menu navigation
bindkey '^[[Z'                  reverse-menu-complete               # Shift-Tab
