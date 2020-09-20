# History settings
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

fpath=( "${HOME}/.local/share/zsh/functions" "${HOME}/.local/share/zsh/completions" '/usr/share/zsh/vendor-completions' "${fpath[@]}" )

bindkey -e
KEYTIMEOUT=1

# For ctrl-q to work
unsetopt flow_control

# bindkey -v
# Change cursor shape for different vi modes.
# function zle-keymap-select {
#   if [[ "${KEYMAP}" = 'vicmd' ]] ||
#      [[ "$1" = 'block' ]]; then
#     echo -ne '\e[1 q'
#   elif [[ "${KEYMAP}" == 'main' ]] ||
#        [[ "${KEYMAP}" == 'viins' ]] ||
#        [[ "${KEYMAP}" = '' ]] ||
#        [[ "$1" = 'beam' ]]; then
#     echo -ne '\e[5 q'
#   fi
# }
# zle -N zle-keymap-select

autoload -U select-word-style
select-word-style bash

zstyle ':zle:transpose-words' word-style space

autoload -Uz run-help
autoload -Uz run-help-sudo run-help-git
autoload -Uz run-tldr

zle -N run-tldr

bindkey '^[h' run-help
bindkey '^[g' run-tldr
# Redefine home and end to fix these keys not working after running run-tldr via shortcut
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

# For del to work
bindkey '^[[3~' delete-char

alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias topgrade="powershell.exe -NoProfile -Command 'cd \$env:USERPROFILE; sudo topgrade'"

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

# Using function here so run-help doesn't treat it as an alias
function sudo() {
  /usr/bin/sudo --preserve-env=PATH -sE $@
}

# Syntax highlighted man pages
export BAT_THEME='OneHalfDark'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

export FZF_DEFAULT_COMMAND='fd --exclude ".git" --hidden --follow -t f'
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
export FZF_ALT_C_COMMAND="fd --no-ignore --exclude '.git' --exclude '.cache' --hidden --follow -t d . "${HOME}""
export FZF_CTRL_T_OPTS="--height 70% --preview-window 'right:60%' --preview 'bat --color=always --style=header,grid --line-range :300 {}'"

source '/usr/share/fzf/key-bindings.zsh'
source '/usr/share/fzf/completion.zsh'

# # vi mode
# bindkey -v
# export KEYTIMEOUT=1

# bindkey -v '^?' backward-delete-char

# # Change cursor shape for different vi modes.
# function zle-keymap-select {
#   if [[ ${KEYMAP} == vicmd ]] ||
#      [[ $1 = 'block' ]]; then
#     echo -ne '\e[1 q'
#   elif [[ ${KEYMAP} == main ]] ||
#        [[ ${KEYMAP} == viins ]] ||
#        [[ ${KEYMAP} = '' ]] ||
#        [[ $1 = 'beam' ]]; then
#     echo -ne '\e[5 q'
#   fi
# }
# zle -N zle-keymap-select
# zle-line-init() {
#     zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
#     echo -ne "\e[5 q"
# }
# zle -N zle-line-init
# echo -ne '\e[5 q' # Use beam shape cursor on startup.
# preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^[e' edit-command-line

bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^U' backward-kill-line

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "${HOME}/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
# zinit light-mode for \
#     zinit-zsh/z-a-rust \
#     zinit-zsh/z-a-as-monitor \
#     zinit-zsh/z-a-patch-dl \
#     zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

# Basic auto/tab complete:
# export ZLE_REMOVE_SUFFIX_CHARS=''
# autoload -Uz compinit
# zmodload zsh/complist
# bindkey '^[[Z' reverse-menu-complete
# zstyle ':completion:*:*:*:default' menu yes select interactive
# zstyle ':completion:*' matcher-list 'r:[[:ascii:]]||[[:ascii:]]=** r:|=* m:{a-z\-}={A-Z\_}'
# bindkey -M menuselect '/' history-incremental-search-forward
# Use vim keys in tab complete menu:
# bindkey -M menuselect 'h' vi-backward-char
# bindkey -M menuselect 'k' vi-up-line-or-history
# bindkey -M menuselect 'l' vi-forward-char
# bindkey -M menuselect 'j' vi-down-line-or-history
# compinit
# Take advantage of $LS_COLORS for completion as well. 
eval "$(dircolors)"
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
setopt globdots	# Include hidden files.

# (experimental, may change in the future)
# some boilerplate code to define the variable `extract` which will be used later
# please remember to copy them
local extract="
# trim input(what you select)
local in=\${\${\"\$(<{f})\"%\$'\0'*}#*\$'\0'}
# get ctxt for current completion(some thing before or after the current word)
local -A ctxt=(\"\${(@ps:\2:)CTXT}\")
# real path
local realpath=\${ctxt[IPREFIX]}\${ctxt[hpre]}\$in
realpath=\${(Qe)~realpath}
"

# give a preview of directory when completing cd
zstyle ':fzf-tab:complete:cd:*' extra-opts --preview=$extract'exa -1 --color=always $realpath'
# disable sort when completing options of any command
# zstyle ':completion:complete:*:options' sort false

zinit wait lucid light-mode for \
  atinit'zicompinit; zicdreplay' \
      zdharma/fast-syntax-highlighting \
      Aloxaf/fzf-tab \
  atload'_zsh_autosuggest_start' \
      zsh-users/zsh-autosuggestions \
  blockf atpull'zinit creinstall -q .' \
      zsh-users/zsh-completions

setopt HIST_FIND_NO_DUPS

zinit light zsh-users/zsh-history-substring-search

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

autoload -Uz set-win-title
precmd_functions+=(set-win-title)

autoload -Uz clcopy
zle -N clcopy
bindkey '^X' clcopy

eval "$(starship init zsh)"

# zinit light marzocchi/zsh-notify

# zstyle ':notify:*' command-complete-timeout 10
# zstyle ':notify:*' expire-time 1000
# zstyle ':notify:*' error-title 'Command failed (in #{time_elapsed})'
# zstyle ':notify:*' success-title 'Command finished (in #{time_elapsed})'
# zstyle ':notify:*' error-sound '/usr/share/sounds/gnome/default/alerts/sonar.ogg'
# zstyle ':notify:*' success-sound '/usr/share/sounds/gnome/default/alerts/drip.ogg'
# zstyle ':notify:*' app-name sh

