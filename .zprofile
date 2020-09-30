export EDITOR='/usr/bin/nvim'
PATH="${HOME}/scripts:${PATH}"
PATH="${PATH}:${HOME}/.cargo/bin"
export GOPATH="${HOME}/go"; PATH="${GOPATH}/bin:${PATH}";
export N_PREFIX="${HOME}/n"; [[ :"${PATH}": == *":${N_PREFIX}/bin:"* ]] || PATH+=":${N_PREFIX}/bin"
PATH="${PATH}:${HOME}/.dotnet/tools"
PATH="${PATH}:${HOME}/.yarn/bin"

