# Include interactive rc files
for conffile in "${ZDOTDIR}"/rc.d/*; do
    source "${conffile}"
done

unset conffile

# To customize prompt, run `p10k configure` or edit ~/.local/dotfiles/zsh/.p10k.zsh.
[[ ! -f ~/.local/dotfiles/zsh/.p10k.zsh ]] || source ~/.local/dotfiles/zsh/.p10k.zsh
