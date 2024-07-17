# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$PATH

# Add GOBIN to PATH
export PATH=$PATH:$HOME/go/bin

# Add postgres client utils (pgql) to PATH
export PATH=/opt/homebrew/opt/libpq/bin:$PATH

# pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$HOME/.config/zsh/custom

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(
  aws
  git
  nvm
  pyenv
  zsh-syntax-highlighting
  zsh-autosuggestions
  starship
)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# fly through shell history
eval "$(mcfly init zsh)"

# rust
source "$HOME/.cargo/env"

# python poetry package manager completions
path+=~/.zfunc
autoload -Uz compinit && compinit

# AWSume alias to source the AWSume script
alias awsume="source \$(pyenv which awsume)"

# Auto-Complete function for AWSume
fpath=(~/.awsume/zsh-autocomplete/ $fpath)


# enable "z" - recent directory jumping
. /opt/homebrew/etc/profile.d/z.sh

# fzf shell integration
source <(fzf --zsh)

# fzf key bindings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# find directory in current directory
function fcd() {
  local dir
  dir=$(fd -t d . | fzf) && cd "$dir"
}

  # find directory in "code/work" directory
function fcw() {
  local dir
  dir=$(fd -t d . ~/code | fzf) && cd "$dir"
}

# find recent directory
function fcz() {
  local dir
  dir=$(z -l 2>&1 | awk 'NR>1 {print substr($0, index($0,$2))}' | fzf) && cd "$dir"
}

# sdkman
# THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

alias v='nvim'

# nuke node_modules relative to current directory (nested instances too)
alias nukem="find . -name \"node_modules\" -type d -prune -exec rm -rf '{}' +"

# automatically run nvm use when entering a directory with a .nvmrc file
autoload -U add-zsh-hook
load-nvmrc() {
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    nvm use --silent
  elif [[ -f .nvmrc && ! -r .nvmrc ]]; then
    echo "🚨 nvmrc exists but is not readable"
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc


