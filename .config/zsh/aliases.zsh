# Manage dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

alias ls='exa --color=always --icons'
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

alias sudo='sudo -sE '

alias open='xdg-open'

alias trash='gio trash'

alias nv='prime-run'

alias spotify="${HOME}/scripts/gtk-enforce-theme-variant -qt dark 'LD_PRELOAD=/usr/lib/spotify-adblock.so spotify'"

alias lzd='lazydocker'

