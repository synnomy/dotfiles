# Created by newuser for 5.2
source ~/.zplug/init.zsh

export PATH="$PATH:$HOME/bin:$HOME/.go/bin:$HOME/.cargo/bin"
export GOPATH=$HOME/.go
export ENHANCD_FILTER="fzf:non-existing-filter"
export RUST_SRC_PATH="$HOME/.multirust/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src"
export PGDATA=/usr/local/var/postgres

# os specific settings
case ${OSTYPE} in
	darwin*)
		export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
		;;
esac

# local variables
local PYTHON2_PACKAGE_PATH="/Users/togegarlic/Library/Python/2.7/lib/python/site-packages"

# alias
alias love="~/Applications/love.app/Contents/MacOS/love"
alias clojure="java -cp ~/clojure-1.8.0.jar clojure.main"
alias e="/usr/local/bin/emacs -nw"

# zmv
autoload -Uz zmv
alias zmv='noglob zmv -W'

# powerline
# . ${PYTHON2_PACKAGE_PATH}/powerline/bindings/zsh/powerline.zsh

zplug "zsh-users/zsh-syntax-highlighting", defer:2

zplug "zsh-users/zsh-completions"


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
