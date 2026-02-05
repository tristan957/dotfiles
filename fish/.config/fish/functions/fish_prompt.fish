if not status is-interactive
    return
end

set -g __fish_git_prompt_char_stateseparator ' '
set -g __fish_git_prompt_describe_style 'branch'
set -U __fish_git_prompt_showcolorhints
# set -g __fish_git_prompt_showconflictstate true
set -U __fish_git_prompt_showdirtystate
set -g __fish_git_prompt_showstashstate true
set -U __fish_git_prompt_showuntrackedfiles
set -g __fish_git_prompt_showupstream 'verbose'
set -U __fish_git_prompt_use_informative_chars

function __prompt_time
    echo -n (date +%H:%M:%S)
end

function __prompt_extras
    set -l PROMPT_EXTRAS ''

    if git rev-parse --quiet &>/dev/null
        set PROMPT_EXTRAS "$PROMPT_EXTRAS $(fish_vcs_prompt "$(tput setaf 39) \b[%s]")"
    end

    # Python virtual environments are so fun
    if set -q VIRTUAL_ENV
        set PROMPT_EXTRAS "$PROMPT_EXTRAS $(tput setaf 105) \b[$(basename "$VIRTUAL_ENV")]"
    end

    if command --query "kubectl"
        set -l kubectl_curr_ctx (kubectl config current-context 2>/dev/null)
        if test $status -eq 0
            set -l kubectl_curr_ns (kubectl config view --minify \
                -o go-template='{{ if .contexts }}{{ with (index .contexts 0).context.namespace }}{{ . }}{{ else }}default{{ end }}{{ else }}default{{ end }}' \
                2>/dev/null)
            set PROMPT_EXTRAS "$PROMPT_EXTRAS $(tput setaf 14) \b[$kubectl_curr_ctx > $kubectl_curr_ns]"
        end
    end

    echo -ne "$PROMPT_EXTRAS"
end

# I could add the container application here:
#   - docker(container)
#   - podman(container)
#   - toolbox(container)
#   - distrobox(container)
#
# But the only time I should see my prompt in a container is with Toolbox or
# Distrobox, so should be all good.
function __prompt_host
    if set --query $container
        sed -n 's/^name="\(.*\)"$/\1/p' </run/.containerenv
    else
        prompt_hostname
    end
end

function __prompt_jobs
    jobs --pid | wc --lines
end

function fish_prompt
    set -l last_status $status
    set -l cwd (prompt_pwd --dir-length=1)
    set -l user_char '$'

    if fish_is_root_user
        set user_char '#'
    end

    set -l mode_char '+'
    if test "$fish_key_bindings" = fish_vi_key_bindings
        switch $fish_bind_mode
            case insert
                set mode_char '○'
            case replace
                set mode_char '◌'
            case replace_one
                set mode_char '◌'
            case operator
                set mode_char '◌'
            case visual
                set mode_char '◙'
            case '*'
                set mode_char '●'
        end
    end

    echo -ne "$(set_color --bold) \b$(tput setaf 208) \b[$last_status $(__prompt_jobs) $(__prompt_time)] $(tput setaf 76) \b[$(whoami)@$(__prompt_host)] $(tput setaf 214) \b[$cwd]$(__prompt_extras) \b$(tput sgr0)\n$mode_char $user_char $(set_color normal)"
end
