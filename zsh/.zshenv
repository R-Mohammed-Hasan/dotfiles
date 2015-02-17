ZDOTDIR="$HOME/.dotfiles/zsh"

skip_global_compinit=1

# Exports
export VIMINIT='let $MYVIMRC="~/.dotfiles/vim/vimrc" | source $MYVIMRC'
EDITOR=vim
VISUAL=$EDITOR
export VISUAL EDITOR
export PAGER=less
export LESSHISTFILE=~/.local/share/lesshst
export MYSQL_HISTFILE=~/.local/share/mysql_history

# Aliases
alias grep="grep --color=auto --binary-files=without-match --devices=skip"
alias quilt="quilt --quiltrc ~/.dotfiles/quiltrc"
alias tmux="tmux -f ~/.dotfiles/tmux.conf"

# Keep SSH_AUTH_SOCK valid across several attachments to the remote tmux session
if [[ `whoami` != root ]]; then
    if [[ -S "$SSH_AUTH_SOCK" ]] && [[ ! -h "$SSH_AUTH_SOCK" ]]; then
        ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
    fi
    export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
fi

# Include local zshenv
if [[ -f "$ZDOTDIR"/.zshenv.local ]]; then
    source "$ZDOTDIR"/.zshenv.local
fi

