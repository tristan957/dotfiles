# Will be added to PATH in programs.fish
set -gx GOBIN "$HOME/.local/bin"
set -gx GOMODCACHE "$XDG_CACHE_HOME/go"
set -gx GOPATH "$XDG_DATA_HOME/go"
# set -gx GOPROXY direct
set -gx GOTELEMETRY off
