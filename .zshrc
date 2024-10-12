# source zsh plugins
local plugin_dir=$HOME/.zsh
for plugin ($plugin_dir/**/*.plugin.zsh) do;
  source $plugin
done

export PATH="$PATH:$HOME/.local/bin"
export XDG_SCREENSHOTS_DIR="$HOME/Screenshots"

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

export PAGER="less"
export MANPAGER="$PAGER"
export EDITOR="nvim"
export VISUAL="$EDITOR"

### aliases ###
alias ezs="eza -aF --group-directories-first"
alias ezl="eza -al --group-directories-first"
alias grep="grep --color=auto"
alias diff="diff --color=auto"
alias ip="ip -color=auto"
alias less="less -R"
alias h="history"

fpath=(~/.zsh/prompts/ $fpath)

autoload -Uz compinit && compinit
autoload -Uz promptinit && promptinit
prompt ruthen1um

zstyle ":completion:*" menu select
zstyle ':completion:*' file-list all
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

bindkey "^ " autosuggest-execute
bindkey "^F" autosuggest-accept

# push dirs to stack
setopt auto_pushd
setopt pushd_ignore_dups

setopt auto_cd

setopt auto_menu

# history options
setopt inc_append_history
setopt hist_ignore_all_dups
setopt hist_no_store
setopt hist_reduce_blanks

setopt extended_glob
