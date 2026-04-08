if command -v podman &>/dev/null; then
    # Required because we use rootless Podman
    export TESTCONTAINERS_RYUK_DISABLED=true
fi
