# .dotfiles

Shell and tool configuration shared between my macOS and Linux environments.

## Setup

```bash
git clone --bare git@github.com:rubber-duck/.dotfiles.git ~/.dotfiles
alias dot='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
dot checkout -f
~/.dotscripts/setup.sh
```

## Structure

```
.zshenv                        # zsh environment (PATH, env vars — loaded for every zsh invocation)
.zshrc                         # zsh interactive config (completion, aliases, prompt, keybindings)
.profile                       # POSIX/bash login shell (PATH, env vars)
.shell/
  completion.zsh               # compinit + styling (case-insensitive, colored, menu select)
  history.zsh                  # 50k lines, shared between sessions, timestamps
  keybindings.zsh              # cross-platform arrow keys, word nav, shift-tab
  aliases.zsh                  # dot alias, user aliases
  tools.zsh                    # completions for starship, uv, bun, dotnet, kubectl, git
  platform/
    darwin.zsh                 # macOS: zsh-specific (completions, FPATH)
    darwin-env.sh             # macOS: PATH (shared by zsh and bash)
    linux.zsh                  # Linux: zsh-specific
    linux-env.sh              # Linux: PATH (shared by zsh and bash)
.tmux.conf                     # tmux config: Ctrl+a prefix, base-index 1, no mouse, true color
.tmux/
  gruvbox-dark.conf            # inlined egel/tmux-gruvbox dark theme (true color)
  keybindings.conf             # custom tmux keybindings
.gitconfig                     # git user, editor, lfs
.config/alacritty/
  alacritty.toml               # window padding, opacity, font (Iosevka Nerd Font)
.dotscripts/
  setup.sh                     # post-clone setup (starship config generation)
  sync_sshconf.sh              # push/pull SSH config to/from 1Password
```

## Notes

- **Bare git repo** - files live in their native locations, no symlinks or extra tools needed. A global `.gitignore` ignores everything by default, with tracked files explicitly whitelisted.
- **No plugin managers** - tpm and similar plugin managers pull and execute arbitrary code from GitHub at runtime with no review step. Instead, themes are security-reviewed and inlined as static config (tmux-gruvbox), or generated from trusted local CLI tools (starship). This way nothing runs that hasn't been read first.
- **macOS is not a dev environment** - dev toolchains (dotnet, bun, volta, node) are only configured on Linux. On macOS, all development happens inside Docker containers via Rancher Desktop, keeping the host machine clean and sandboxed from project dependencies. Linux is usually just a workstation VM image or docker dev container.
- **Platform split** - cross-platform config lives in shared files; macOS and Linux specifics are isolated in `.shell/platform/`
- **Conditional loading** - all tool completions and paths are guarded with existence checks so missing tools are silently skipped
- **SSH config in 1Password** - SSH config contains IPs, hostnames, and usernames that shouldn't live in a public repo. `sync_sshconf.sh` stores it as a Secure Note in 1Password and syncs via the `op` CLI
