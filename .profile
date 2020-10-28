PATH="${HOME}/scripts:${PATH}"
PATH="${PATH}:${HOME}/.local/bin"
PATH="${PATH}:${HOME}/.cargo/bin"
export GOPATH="${HOME}/go"; PATH="${GOPATH}/bin:${PATH}";
export N_PREFIX="${HOME}/n"; PATH="${N_PREFIX}/bin:${PATH}"
PATH="${PATH}:${HOME}/.dotnet/tools"
PATH="${PATH}:${HOME}/.yarn/bin"

export QT_QPA_PLATFORMTHEME='gnome'
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'
export LESS='-R'
# Disable less history
export LESSHISTFILE=-

export DOTNET_CLI_TELEMETRY_OPTOUT=1

# Syntax highlighted man pages
export BAT_THEME='OneHalfDark'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

FZF_FD_COMMAND="fd --color=always -E '.git' -E '.nv' --hidden --follow"
export FZF_DEFAULT_COMMAND="${FZF_FD_COMMAND} -t f"
export FZF_DEFAULT_OPTS='--ansi'
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
export FZF_CTRL_T_OPTS="--height 70% --preview-window 'right:60%' --preview 'bat --color=always --style=header,grid --line-range :300 {} 2> /dev/null || exa -1 --color=always {}'"
export FZF_ALT_C_COMMAND="fd --no-ignore -E '.git' -E '.cache' -E '.rustup' -E '.cargo' -E 'coc' --hidden --follow -t d . ${HOME}"
export FZF_ALT_C_OPTS="--preview 'exa -1 --color=always {}'"


export FZF_COMPLETION_OPTS="${FZF_CTRL_T_OPTS}"
# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  eval "${FZF_FD_COMMAND}" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  eval "${FZF_FD_COMMAND}" -t d . "$1"
}
