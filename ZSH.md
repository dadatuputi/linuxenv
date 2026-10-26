# zsh

`.zshrc` is plain zsh with no framework. oh-my-zsh and Powerlevel10k were
retired: every host had them commented out in favour of oh-my-posh.

What it sets up, in order:

1. **PATH**: `~/.local/bin`, `~/bin` and `/opt/homebrew/bin` (if present),
   de-duplicated with `typeset -U`.
2. **Environment**: `LANG=en_US.UTF-8` (not `LC_ALL`), `EDITOR=vim`, `less -R`.
   `TERM` is left to the terminal and tmux.
3. **History**: 50k lines, shared between shells, timestamps, duplicates
   dropped, commands starting with a space not recorded.
4. **Keys**: emacs mode; Home/End/Delete for iTerm2, the Proxmox console and
   tmux; Up/Down search history for what is already typed.
5. **Completion**: `compinit` with a daily cache check, menu selection,
   case-insensitive matching. Skipped when `~/.zshrc.local.pre` sets
   `LINUXENV_SKIP_COMPINIT=1` (for example when using zsh-autocomplete).
6. **Prompt**: oh-my-posh with `~/.config/oh-my-posh/atomic.omp.json` if
   both exist, else a plain two-line prompt.
7. **Optional tools**, each loaded only if installed: iTerm2 shell
   integration, zsh-autosuggestions, fzf (Ctrl-R, Ctrl-T, Alt-C), zoxide.
8. **`~/.zshrc.local`**: per-machine settings.
9. **zsh-syntax-highlighting** last, as it requires.

## Per-machine settings

Put anything that only applies to one machine in `~/.zshrc.local` (or
`~/.zshrc.local.pre` for things that must run before completion). The file is
not committed, so it is the place for anything private, such as SSH agent
sockets, tokens read from files, or tool paths. See `.zshrc.local.example`.

`conda init zsh` writes into `~/.zshrc`, which is now a link into this repo.
After running it, move the block it adds into `~/.zshrc.local` and
`git checkout .zshrc`.

## oh-my-posh

Every machine uses the same prompt. `install.sh --posh` installs
oh-my-posh to `~/.local/bin` on Debian and through Homebrew on macOS. The theme is upstream
`atomic` with the right-aligned block removed, which fixed a blue fill bar on
prompt redraw.
