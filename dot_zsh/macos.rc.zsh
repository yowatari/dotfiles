# Cache `brew shellenv` output to avoid forking on every shell startup
_brew_env_cache="${XDG_CACHE_HOME:-$HOME/.cache}/brew_shellenv.zsh"
if [[ ! -s $_brew_env_cache || /opt/homebrew/bin/brew -nt $_brew_env_cache ]]; then
  /opt/homebrew/bin/brew shellenv > $_brew_env_cache
fi
source $_brew_env_cache
unset _brew_env_cache

export HOMEBREW_NO_ANALYTICS=1

# GNU tools PATH (for script compatibility)
local -a gnu_tools=(coreutils findutils gawk grep gnu-sed gnu-tar gnu-which)
for tool in $gnu_tools; do
  local gnubin="$HOMEBREW_PREFIX/opt/$tool/libexec/gnubin"
  if [[ -d "$gnubin" ]]; then
    path=($gnubin(N-/) $path)
  fi
done

# Java
if [[ -d "$HOMEBREW_PREFIX/opt/openjdk/bin" ]]; then
  path=($HOMEBREW_PREFIX/opt/openjdk/bin(N-/) $path)
fi
