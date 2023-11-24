# install binaries with `eget`
local bin_dir=~/bin
if ! [[ -d $bin_dir ]]; then
  mkdir $bin_dir
  curl -o $bin_dir/eget.sh https://zyedidia.github.io/eget.sh
  shasum -a 256 $bin_dir/eget.sh
  (cd $bin_dir && bash $bin_dir/eget.sh)
  rm $bin_dir/eget.sh

  eget --to $bin_dir --file eza eza-community/eza
  eget --to $bin_dir --file vivid sharkdp/vivid
  eget --to $bin_dir --file fd sharkdp/fd
  eget --to $bin_dir --file yt-dlp yt-dlp/yt-dlp
  eget --to $bin_dir --file texlab latex-lsp/texlab
fi

# source zsh plugins
local plugin_dir=~/.zsh
for plugin ($plugin_dir/**/*.plugin.zsh) do;
  source $plugin
done

if [[ -f ~/.zshrc.private ]]; then
  source ~/.zshrc.private
fi

export PATH=$PATH:$bin_dir:~/.local/bin

# generate LS_COLORS
export LS_COLORS="$(vivid generate catppuccin-mocha)"

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

autoload -Uz compinit
compinit

zstyle ":completion:*" menu select
zstyle ':completion:*' file-list all
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

bindkey "^ " autosuggest-execute
bindkey "^F" autosuggest-accept

setopt append_history
setopt auto_pushd
setopt pushd_ignore_dups
setopt extended_glob

export SAVEHIST=10000
export HISTSIZE=10000
export HISTFILE=~/.zsh_history

setopt prompt_subst

function status() {
  if [[ "$?" -eq "0" ]]; then
    echo -n $'(%{\e[92m%}'$?'%{\e[0m%})'
  else
    echo -n $'(%{\e[91m%}'$?'%{\e[0m%})'
  fi
}

PROMPT=$'[%{\e[3;96m%}%n%{\e[0;95m%}:%{\e[93m%}%~%{\e[0m%}]$(status)$ '
