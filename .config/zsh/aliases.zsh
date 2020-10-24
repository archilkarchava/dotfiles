# Manage dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias cfg='config'

alias ls='exa --color=always'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'
alias tree='ls --tree'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias vim='nvim'
alias vi='nvim'

alias python='python3'
alias pip='pip3'

alias open='xdg-open'

alias trash='gio trash'

alias nv='prime-run'

alias spotify='gtk-launch spotify'

alias lzd='lazydocker'

alias vicfg="${EDITOR} ${HOME}/.config/nvim/init.vim"

alias vial="${EDITOR} ${HOME}/.config/alacritty/alacritty.yml"

alias vizrc="${EDITOR} ${ZDOTDIR}/.zshrc"
alias vizp="${EDITOR} ${ZDOTDIR}/.zprofile"
alias vip="${EDITOR} ${HOME}/.profile"
alias vizal="${EDITOR} ${ZDOTDIR}/aliases.zsh"
