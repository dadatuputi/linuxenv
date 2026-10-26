# linuxenv

Shared shell setup: zsh, tmux and the oh-my-posh prompt, for Debian
(including Proxmox hosts) and macOS with iTerm2.

| File | Linked to | What it is |
|---|---|---|
| `.zshrc` | `~/.zshrc` | Shared zsh config (no framework: plain zsh + optional plugins) |
| `.zshrc.local.example` | copy to `~/.zshrc.local` | Per-machine settings, never committed |
| `.tmux.conf` | `~/.tmux.conf` | tmux config, plugins via TPM |
| `oh-my-posh/atomic.omp.json` | `~/.config/oh-my-posh/atomic.omp.json` | Prompt theme (upstream atomic, right-hand block removed) |
| `.vimrc` | `~/.vimrc` | Minimal vim settings |

## Install

```bash
git clone https://github.com/dadatuputi/linuxenv ~/.local/share/linuxenv
~/.local/share/linuxenv/install.sh --packages --posh
chsh -s "$(command -v zsh)"   # if zsh is not already the login shell
```

`install.sh` symlinks the files above into `$HOME` and moves anything already
there to `<file>.bak.<timestamp>`. Re-running it is safe. To update a machine:
`git -C ~/.local/share/linuxenv pull`, then open a new shell (or
`prefix + r` in tmux).

The prompt needs a Nerd Font in the terminal. iTerm2 uses MesloLGS NF:
https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k

See [ZSH.md](ZSH.md), [TMUX.md](TMUX.md) and [PACKAGES.md](PACKAGES.md).
