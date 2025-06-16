export GOBIN="$HOME/.local/bin"
export GOMODCACHE="${XDG_CACHE_HOME:-$HOME/.cache}/go"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export GOPROXY=direct
export GOTELEMETRY=off

export PATH="$GOPATH/bin:$PATH"
