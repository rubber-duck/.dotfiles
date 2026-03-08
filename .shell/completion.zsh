# ===== Completion System =====
autoload -Uz compinit

# Speed up compinit by only checking cache once a day
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

# Completion styling
zstyle ':completion:*' menu select                                                  # Interactive menu selection
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'                           # Case-insensitive matching
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}                               # Colored completions
zstyle ':completion:*' group-name ''                                                # Group completions by type
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}-- no matches --%f'
zstyle ':completion:*' squeeze-slashes true                                         # /u/l/b → /usr/local/bin
zstyle ':completion:*' complete-options true                                        # Complete option flags
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w"
