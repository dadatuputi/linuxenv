# tmux

`.tmux.conf` needs tmux 3.2 or later. Plugins are managed by
[TPM](https://github.com/tmux-plugins/tpm), which the config clones on first
start if it is missing.

Plugins: tmux-sensible, tmux-resurrect (with pane contents),
tmux-better-mouse-mode, tmux-powerline.

Settings beyond the plugins:

- `tmux-256color` with true colour and italics passed through to xterm-type
  terminals (iTerm2).
- Uses the login shell (`$SHELL`) rather than a hard-coded `/usr/bin/zsh`.
- Mouse on, 50k lines of scrollback, windows and panes numbered from 1,
  windows renumbered when one closes.
- `Shift+Left` / `Shift+Right` move the current window.
- Splits and new windows open in the current directory.
- Pane titles on the bottom border: `index - title (command)`.
- `prefix + r` reloads the config.

## Plugins

```
prefix + I   install plugins
prefix + U   update plugins
```
