PATH="${HOME}/scripts:${PATH}"
PATH="${PATH}:${HOME}/.cargo/bin"
export GOPATH="${HOME}/go"; PATH="${GOPATH}/bin:${PATH}";
export N_PREFIX="${HOME}/n"; PATH="${N_PREFIX}/bin:${PATH}"
PATH="${PATH}:${HOME}/.dotnet/tools"
PATH="${PATH}:${HOME}/.yarn/bin"

export QT_QPA_PLATFORMTHEME='gnome'
export EDITOR='nvim'
export VISUAL='nvim'

export DOTNET_CLI_TELEMETRY_OPTOUT=1

# Syntax highlighted man pages
export BAT_THEME='OneHalfDark'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

export FZF_DEFAULT_COMMAND='fd --exclude ".git" --hidden --follow -t f'
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
export FZF_ALT_C_COMMAND="fd --no-ignore --exclude '.git' --exclude '.cache' --exclude '.rustup' --exclude '.cargo' --exclude 'coc' --hidden --follow -t d . ${HOME}"
export FZF_CTRL_T_OPTS="--height 70% --preview-window 'right:60%' --preview 'bat --color=always --style=header,grid --line-range :300 {}'"

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}
