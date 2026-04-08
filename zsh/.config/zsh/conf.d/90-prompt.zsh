setopt PROMPT_SUBST

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats '%b'
zstyle ':vcs_info:git:*' actionformats '%b|%a'

function __prompt_host() {
    if [[ -n "$container" ]]; then
        sed -n 's/^name="\(.*\)"$/\1/p' </run/.containerenv
    else
        hostname
    fi
}

function __prompt_extras() {
    local extras=''

    vcs_info
    if [[ -n "$vcs_info_msg_0_" ]]; then
        extras+=" %F{blue}[$vcs_info_msg_0_]"
    fi

    if [[ -n "${VIRTUAL_ENV+x}" ]]; then
        extras+=" %F{magenta}[$(basename "$VIRTUAL_ENV")]"
    fi

    if (( $+commands[kubectl] )); then
        local ctx
        ctx=$(kubectl config current-context 2>/dev/null)
        if [[ $? -eq 0 ]]; then
            local ns
            ns=$(kubectl config view --minify \
                -o go-template='{{ if .contexts }}{{ with (index .contexts 0).context.namespace }}{{ . }}{{ else }}default{{ end }}{{ else }}default{{ end }}' \
                2>/dev/null)
            extras+=" %F{cyan}[$ctx > $ns]"
        fi
    fi

    printf '%s' "$extras"
}

PROMPT='%B%F{red}[%? %(1j.%j.0) %*] %F{green}[%n@$(__prompt_host)] %F{yellow}[%1~]$(__prompt_extras)%f%b
%B%# %b'
PS2='%B> %b'
