# Created by newuser for 5.2
source ~/.zplug/init.zsh

export PATH="$PATH:$HOME/bin:$HOME/.go/bin"
export GOPATH=$HOME/.go
export ENHANCD_FILTER="fzf:non-existing-filter"
export PGDATA=/usr/local/var/postgres

# ls colors for termite
eval $(dircolors ~/.dircolors)

# alias
alias reload='exec zsh -l'

# prompt
PROMPT='$ '
RPROMPT='(%d)'

# new line before each prompt lines
precmd() { print "" }

# zmv
autoload -Uz zmv
alias zmv='noglob zmv -W'

zplug "zsh-users/zsh-syntax-highlighting", defer:2

zplug "zsh-users/zsh-completions"
zplug "zplug/zplug"

zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf
zplug "junegunn/fzf", as:command, use:bin/fzf-tmux

zplug "b4b4r07/enhancd", use:init.sh, on:"junegunn/fzf-bin"

zplug "peco/peco", as:command, from:gh-r, use:"*amd64*"
zplug "b4b4r07/dotfiles", as:command, use:bin/peco-tmux

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f ~/.zshrc.local ] && source ~/.zshrc.local
