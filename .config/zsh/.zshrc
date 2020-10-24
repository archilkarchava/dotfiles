fpath=( "${ZDOTDIR}/functions" "${ZDOTDIR}/completions" '/usr/share/zsh/vendor-completions' "${fpath[@]}" )

bindkey -e
KEYTIMEOUT=1

# For ctrl-q to work
unsetopt flow_control

WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

autoload -Uz select-word-style
select-word-style normal

zstyle ':zle:transpose-words' word-style whitespace

autoload -Uz run-help
unalias run-help
autoload -Uz run-help-git run-help-ip run-help-openssl run-help-p4 run-help-sudo run-help-svk run-help-svn

autoload -Uz run-tldr

zle -N run-tldr

bindkey '^[h' run-help
bindkey '^[g' run-tldr

# Make home and end keys always work outside tmux
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
# Make home and end keys always work inside tmux
bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line

# For del to work
bindkey '^[[3~' delete-char

source '/usr/share/fzf/key-bindings.zsh'
source '/usr/share/fzf/completion.zsh'

fzf-direct-completion() {
  FZF_COMPLETION_TRIGGER= fzf-completion
}
zle -N fzf-direct-completion
bindkey '^[[Z' fzf-direct-completion

for fzf_direct_completion in "${ZDOTDIR}/completions/fzf"/*; do
  source "${fzf_direct_completion}"
done

# Edit line in vim with alt-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^[e' edit-command-line

bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^U' backward-kill-line

# Install zinit if not installed already
if [[ ! -f ${ZDOTDIR}/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "${ZDOTDIR}/.zinit" && command chmod g-rwX "${ZDOTDIR}/.zinit"
    command git clone https://github.com/zdharma/zinit "${ZDOTDIR}/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "${ZDOTDIR}/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Take advantage of $LS_COLORS for completion
eval "$(dircolors)"
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# Setting the insert-tab tag to false will prevent a tab from being inserted when there are no characters to the left of the cursor.
zstyle ':completion:*' insert-tab false
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

# History settings
[[ -z "${HISTFILE}" ]] && HISTFILE="${ZDOTDIR}/.zsh_history"
HISTSIZE=290000
SAVEHIST="${HISTSIZE}"

zinit wait lucid for OMZ::lib/history.zsh
# Appends every command to the history file once it is executed
setopt inc_append_history
# Reloads the history whenever you use it
setopt share_history

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
autoload -Uz fix-history

# List current token
autoload -Uz list-current-token
zle -N list-current-token
bindkey '^[l' list-current-token

source "${ZDOTDIR}/aliases.zsh"

eval "$(starship init zsh)"
