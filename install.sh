#!/usr/bin/env bash
# install.sh - link the linuxenv dotfiles into $HOME.
#
#   ./install.sh            link files (existing files are moved to *.bak.<date>)
#   ./install.sh --packages also install zsh, tmux, git, curl, vim and the
#                           optional zsh plugins (apt on Debian, brew on macOS)
#   ./install.sh --posh     also install oh-my-posh (~/.local/bin on Debian,
#                           Homebrew on macOS)
#
# Safe to re-run: links that already point here are left alone.
set -euo pipefail

repo=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
stamp=$(date +%Y%m%d-%H%M%S)
want_packages=0
want_posh=0
for arg in "$@"; do
  case $arg in
    --packages) want_packages=1 ;;
    --posh) want_posh=1 ;;
    -h|--help) sed -n '2,10p' "$0"; exit 0 ;;
    *) echo "unknown option: $arg" >&2; exit 2 ;;
  esac
done

link() {
  local src=$repo/$1 dst=$2
  mkdir -p "$(dirname "$dst")"
  if [[ -L $dst && $(readlink "$dst") == "$src" ]]; then
    echo "ok      $dst"
    return
  fi
  if [[ -e $dst || -L $dst ]]; then
    mv "$dst" "$dst.bak.$stamp"
    echo "backup  $dst -> $dst.bak.$stamp"
  fi
  ln -s "$src" "$dst"
  echo "linked  $dst -> $src"
}

if (( want_packages )); then
  if [[ $(uname) == Darwin ]]; then
    brew install zsh tmux git vim zsh-autosuggestions zsh-syntax-highlighting fzf
  else
    sudo=""; (( EUID == 0 )) || sudo=sudo
    $sudo apt-get update
    $sudo apt-get install -y zsh tmux git curl vim locales \
      zsh-autosuggestions zsh-syntax-highlighting fzf
  fi
fi

if (( want_posh )); then
  if [[ $(uname) == Darwin ]]; then
    brew install jandedobbeleer/oh-my-posh/oh-my-posh
  else
    mkdir -p "$HOME/.local/bin"
    curl -fsSL https://ohmyposh.dev/install.sh | bash -s -- -d "$HOME/.local/bin"
  fi
fi

link .zshrc "$HOME/.zshrc"
link .tmux.conf "$HOME/.tmux.conf"
link .vimrc "$HOME/.vimrc"
link oh-my-posh/atomic.omp.json "$HOME/.config/oh-my-posh/atomic.omp.json"

if [[ ! -d $HOME/.tmux/plugins/tpm ]]; then
  git clone --depth=1 https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi
"$HOME/.tmux/plugins/tpm/bin/install_plugins" >/dev/null && echo "ok      tmux plugins"

if [[ ! -e $HOME/.zshrc.local ]]; then
  echo "note    no ~/.zshrc.local; see $repo/.zshrc.local.example for per-host settings"
fi
if [[ $(basename "${SHELL:-}") != zsh ]]; then
  echo "note    login shell is ${SHELL:-unset}; run: chsh -s \"\$(command -v zsh)\""
fi
