# Modern tool aliases
if command -v nvim &>/dev/null; then
  alias vim=nvim
fi

if command -v eza &>/dev/null; then
  alias ls="eza -aF"
  alias ll="eza -laF"
  alias la="eza -aF"
  alias lla="eza -laF"
fi

if command -v bat &>/dev/null; then
  alias cat="bat --paging=never"
fi

if command -v delta &>/dev/null; then
  alias diff=delta
fi

if command -v duf &>/dev/null; then
  alias du=duf
fi

if command -v sheldon &>/dev/null; then
  eval "$(sheldon source)"
fi

# fzf
export FZF_DEFAULT_COMMAND="fd --type f"
export FZF_DEFAULT_OPTS="--height 50% --reverse"
export FZF_CTRL_T_COMMAND="rg --files --hidden --follow --glob '!.git/*'"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=header,grid --line-range :100 {}'"
export FZF_ALT_C_COMMAND="fd --type d"

# lime prompt
export LIME_SHOW_HOSTNAME=1
export LIME_DIR_DISPLAY_COMPONENTS=3
export LIME_USER_COLOR=109
export LIME_DIR_COLOR=143
export LIME_GIT_COLOR=109

if command -v mise &>/dev/null; then
    eval "$($HOME/.local/bin/mise activate zsh)"
fi

if [[ -f $HOME/.local/share/mise/installs/gcloud/latest/completion.zsh.inc ]]; then
  source "$HOME/.local/share/mise/installs/gcloud/latest/completion.zsh.inc"
fi

# Cache directory for generated completion scripts
typeset -g _ZSH_COMPLETION_CACHE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
[[ -d $_ZSH_COMPLETION_CACHE ]] || mkdir -p $_ZSH_COMPLETION_CACHE

if command -v aws-vault &>/dev/null; then
  if command -v pass &>/dev/null; then
    export AWS_VAULT_BACKEND=pass
    export AWS_VAULT_PASS_PREFIX=aws-vault
  fi
  local _av_cache="$_ZSH_COMPLETION_CACHE/aws-vault.zsh"
  if [[ ! -s $_av_cache || $(command -v aws-vault) -nt $_av_cache ]]; then
    aws-vault --completion-script-zsh > $_av_cache
  fi
  source $_av_cache
fi

if command -v pack &>/dev/null; then
  local _pack_cache="$_ZSH_COMPLETION_CACHE/pack.zsh"
  if [[ ! -s $_pack_cache || $(command -v pack) -nt $_pack_cache ]]; then
    cp "$(pack completion --shell zsh)" $_pack_cache
  fi
  source $_pack_cache
fi

# homebrew packages (use $HOMEBREW_PREFIX from cached brew shellenv)
if [[ -n $HOMEBREW_PREFIX && -d "$HOMEBREW_PREFIX/opt/mysql-client/bin" ]]; then
  export PATH="$HOMEBREW_PREFIX/opt/mysql-client/bin:$PATH"
fi
