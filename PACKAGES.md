# Packages

`install.sh --packages` installs these.

Debian:

```bash
apt install zsh tmux git curl vim locales zsh-autosuggestions zsh-syntax-highlighting fzf
```

macOS (Homebrew):

```bash
brew install zsh tmux git vim zsh-autosuggestions zsh-syntax-highlighting fzf
```

Optional, picked up automatically if installed: `zoxide`.

If `en_US.UTF-8` is missing on Debian (`locale -a`), enable it with
`dpkg-reconfigure locales`.
