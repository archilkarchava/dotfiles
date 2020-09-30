# History settings
[[ -z "${HISTFILE}" ]] && HISTFILE=~/.zsh_history
HISTSIZE=290000
SAVEHIST="${HISTSIZE}"

fpath=( "${HOME}/.local/share/zsh/functions" "${HOME}/.local/share/zsh/completions" '/usr/share/zsh/vendor-completions' "${fpath[@]}" )

bindkey -e
KEYTIMEOUT=1

# For ctrl-q to work
unsetopt flow_control

autoload -U select-word-style
select-word-style bash

zstyle ':zle:transpose-words' word-style space

autoload -U run-help
autoload run-help-sudo run-help-git
autoload -U run-tldr

zle -N run-tldr

bindkey '^[h' run-help
bindkey '^[g' run-tldr

# Redefine home and end to fix these keys not working after running run-tldr via shortcut
bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line

# For del to work
bindkey '^[[3~' delete-char

# Manage dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

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

alias sudo='sudo -sE '

alias systemctl='sudo systemctl'

alias nv='prime-run'

alias spotify="${HOME}/scripts/gtk-enforce-theme-variant -qt dark 'LD_PRELOAD=/usr/lib/spotify-adblock.so spotify'"

alias lzd='lazydocker'

source '/usr/share/fzf/key-bindings.zsh'
source '/usr/share/fzf/completion.zsh'

# Edit line in vim with alt-e:
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

# Take advantage of $LS_COLORS for completion
eval "$(dircolors)"
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# Include hidden files
setopt globdots	

setopt HIST_FIND_NO_DUPS

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

zinit wait lucid if'[[ "$DISPLAY" != "" ]]' has'xdotool' has'wmctrl' atload"
  zstyle ':notify:*' command-complete-timeout 20;
  zstyle ':notify:*' expire-time 1000;
  zstyle ':notify:*' error-title 'Command failed (in #{time_elapsed})';
  zstyle ':notify:*' success-title 'Command finished (in #{time_elapsed})';
  zstyle ':notify:*' app-name sh;
  zstyle ':notify:*' enable-on-ssh no;
" for marzocchi/zsh-notify

zinit wait lucid has'git' for wfxr/forgit

zinit wait lucid for OMZP::command-not-found
zinit wait lucid has'systemctl' for OMZP::systemd
zinit wait lucid has'yarn' for OMZP::yarn

zinit wait lucid atload"
  bindkey '^[[A' history-substring-search-up;
  bindkey '^[[B' history-substring-search-down;
  bindkey -M emacs '^P' history-substring-search-up;
  bindkey -M emacs '^N' history-substring-search-down;
" for zsh-users/zsh-history-substring-search

zinit wait lucid light-mode for \
  atinit'zicompinit; zicdreplay' \
      zdharma/fast-syntax-highlighting \
  has'fzf' \
      Aloxaf/fzf-tab \
  atload'_zsh_autosuggest_start' \
      zsh-users/zsh-autosuggestions \
  blockf atpull'zinit creinstall -q .' \
      zsh-users/zsh-completions

# Change terminal tab title based on pwd
autoload -Uz set-win-title
precmd_functions+=(set-win-title)

# Copy current command line buffer via ctrl+x
autoload -Uz clcopy
zle -N clcopy
bindkey '^X' clcopy

# Fix corrupt history file
autoload -U fix-history

eval "$(starship init zsh)"
