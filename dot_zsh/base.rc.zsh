# disable stty
stty stop undef
stty start undef

# completion
# Run full compinit at most once per day; otherwise use cached dump (-C)
autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi
setopt list_types
setopt auto_resume
setopt auto_list
setopt auto_menu
setopt auto_cd
setopt auto_param_keys
setopt auto_param_slash
setopt magic_equal_subst
setopt equals
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*:default' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# history
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups
setopt extended_history
setopt hist_verify
setopt share_history

# glob
setopt extended_glob
setopt numeric_glob_sort

# misc
setopt correct
setopt prompt_subst
setopt nobeep
setopt long_list_jobs
setopt autopushd
setopt pushd_ignore_dups
setopt print_eight_bit
unsetopt promptcr

# keybind
bindkey -d
bindkey -e

# prevent accidental logout
setopt IGNOREEOF

# pager
export LESS='-i -R -S -W'
export PAGER=less
