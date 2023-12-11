# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

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

# pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# fly through shell history
eval "$(mcfly init zsh)"

# rust
source "$HOME/.cargo/env"

# opam configuration
[[ ! -r /Users/sock/.opam/opam-init/init.zsh ]] || source /Users/sock/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# pnpm
export PNPM_HOME="/Users/sock/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# python poetry package manager completions
path+=~/.zfunc
autoload -Uz compinit && compinit

# AWSume alias to source the AWSume script
alias awsume="source \$(pyenv which awsume)"

# Auto-Complete function for AWSume
# Auto-Complete function for AWSume
fpath=(~/.awsume/zsh-autocomplete/ $fpath)
. "$HOME/.cargo/env"
