# ~/.zshrc - shared zsh config from github.com/dadatuputi/linuxenv
#
# Works on Debian and macOS. Anything that only
# belongs on one machine goes in ~/.zshrc.local, which is sourced at the end
# and is never committed. See .zshrc.local.example.

# --- PATH -------------------------------------------------------------------
# typeset -U drops duplicate entries, so re-sourcing this file is harmless.
typeset -U path PATH
path=(
  $HOME/.local/bin
  $HOME/bin
  /opt/homebrew/bin(N)
  $path
)
export PATH

# --- Locale and editor ------------------------------------------------------
# Set LANG only. Forcing LC_ALL overrides every per-category setting and
# breaks tools that expect to change one category.
export LANG=${LANG:-en_US.UTF-8}
export EDITOR=${EDITOR:-vim}
export VISUAL=$EDITOR
export PAGER=${PAGER:-less}
export LESS='-R -F -X -i'

# Do not export TERM here. The terminal (iTerm2) and tmux each set the right
# value; forcing xterm-256color inside tmux breaks italics and true colour.

# --- History ----------------------------------------------------------------
HISTFILE=${HISTFILE:-$HOME/.zsh_history}
HISTSIZE=50000
SAVEHIST=50000
setopt extended_history       # timestamp and duration in the history file
setopt share_history          # share history across open shells
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space      # a leading space keeps a command out of history
setopt hist_reduce_blanks
setopt hist_verify            # show !! expansions before running them

# --- Shell behaviour --------------------------------------------------------
setopt auto_cd
setopt auto_pushd pushd_ignore_dups pushd_silent
setopt interactive_comments
setopt no_beep

# --- Key bindings -----------------------------------------------------------
bindkey -e
# Home/End/Delete across iTerm2, the Proxmox console and tmux.
bindkey '^[[H'  beginning-of-line
bindkey '^[[F'  end-of-line
bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line
bindkey '^[[3~' delete-char
# Up/Down search history for what is already typed.
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
bindkey '^[OA' up-line-or-beginning-search
bindkey '^[OB' down-line-or-beginning-search

# --- Completion -------------------------------------------------------------
# A host that uses zsh-autocomplete sets LINUXENV_SKIP_COMPINIT=1 in
# ~/.zshrc.local.pre, because that plugin runs compinit itself.
[[ -r $HOME/.zshrc.local.pre ]] && source $HOME/.zshrc.local.pre

if [[ -z $LINUXENV_SKIP_COMPINIT ]]; then
  [[ -d /opt/homebrew/share/zsh/site-functions ]] &&
    fpath=(/opt/homebrew/share/zsh/site-functions $fpath)
  autoload -Uz compinit
  # Re-check the completion dump at most once a day; -C skips the check.
  _dumps=( ${ZDOTDIR:-$HOME}/.zcompdump(N.mh+24) )
  if (( $#_dumps )) || [[ ! -e ${ZDOTDIR:-$HOME}/.zcompdump ]]; then
    compinit
  else
    compinit -C
  fi
  unset _dumps
  zstyle ':completion:*' menu select
  zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
  zstyle ':completion:*' use-cache on
  zstyle ':completion:*' cache-path ${XDG_CACHE_HOME:-$HOME/.cache}/zsh
fi

# --- Aliases ----------------------------------------------------------------
if [[ $OSTYPE == darwin* ]]; then
  alias ls='ls -G'
else
  alias ls='ls --color=auto'
fi
alias ll='ls -lh'
alias la='ls -lAh'
alias grep='grep --color=auto'

# --- Prompt -----------------------------------------------------------------
# oh-my-posh with the repo's atomic theme when both are present, otherwise a
# plain two-line prompt so a fresh box is still usable.
LINUXENV_OMP_THEME=${LINUXENV_OMP_THEME:-$HOME/.config/oh-my-posh/atomic.omp.json}
if (( $+commands[oh-my-posh] )) && [[ -r $LINUXENV_OMP_THEME ]]; then
  eval "$(oh-my-posh init zsh --config "$LINUXENV_OMP_THEME")"
else
  PROMPT='%F{cyan}%n@%m%f %F{yellow}%~%f
%(?.%F{green}.%F{red})%#%f '
fi

# --- Integrations -----------------------------------------------------------
[[ -r $HOME/.iterm2_shell_integration.zsh ]] && source $HOME/.iterm2_shell_integration.zsh

# Optional plugins, loaded only if installed (apt or brew).
for _f in \
  /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh \
  /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh; do
  [[ -r $_f ]] && { source $_f; break; }
done
if (( $+commands[fzf] )); then
  # fzf 0.48+ prints its own integration; older Debian builds ship a file.
  if ! source <(fzf --zsh 2>/dev/null) 2>/dev/null || ! (( $+widgets[fzf-history-widget] )); then
    [[ -r /usr/share/doc/fzf/examples/key-bindings.zsh ]] &&
      source /usr/share/doc/fzf/examples/key-bindings.zsh
  fi
fi
(( $+commands[zoxide] )) && eval "$(zoxide init zsh)"

# --- Host-specific ----------------------------------------------------------
[[ -r $HOME/.zshrc.local ]] && source $HOME/.zshrc.local

# zsh-syntax-highlighting must be the last thing sourced.
for _f in \
  /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
  /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh; do
  [[ -r $_f ]] && { source $_f; break; }
done
unset _f
