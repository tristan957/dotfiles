$env.PROMPT_INDICATOR_VI_NORMAL = ""
$env.PROMPT_INDICATOR_VI_INSERT = ""
$env.PROMPT_MULTILINE_INDICATOR = "::: "
$env.PROMPT_COMMAND_RIGHT = ""

# I could add the container application here:
#   - docker(container)
#   - podman(container)
#   - toolbox(container)
#   - distrobox(container)
#
# But the only time I should see my prompt in a container is with Toolbox or
# Distrobox, so should be all good.
def __prompt_host []: nothing -> string {
    if ($env.container? | default "" | is-not-empty) {
        open /run/.containerenv
        | lines
        | parse --regex '^name="(?<name>.*)"$'
        | get name.0?
        | default ""
    } else {
        sys host | get hostname
    }
}

def __prompt_jobs []: nothing -> int {
    job list | length
}

def __prompt_time []: nothing -> string {
    date now | format date "%H:%M:%S"
}

# Reuse the same `git-prompt.sh` that powers the bash/fish prompts instead of
# reimplementing its status parsing. Its location is resolved once (relative
# to the `git` binary in use, with a few common fallbacks) since it won't
# change for the life of the shell session.
def __resolve_git_prompt_script []: nothing -> string {
    let exec_root = (
        do --ignore-errors { git --exec-path }
        | complete
        | get stdout
        | str trim
        | path dirname
        | path dirname
    )

    let candidates = (
        (
            if ($exec_root | is-not-empty) {
                [
                    ($exec_root | path join "share" "git" "contrib" "completion" "git-prompt.sh")
                    ($exec_root | path join "share" "git-core" "contrib" "completion" "git-prompt.sh")
                ]
            } else {
                []
            }
        )
        | append [
            "/usr/share/git-core/contrib/completion/git-prompt.sh"
            "/Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh"
        ]
        | append (
            if ($env.HOMEBREW_PREFIX? | is-not-empty) {
                [($env.HOMEBREW_PREFIX | path join "etc" "bash_completion.d" "git-prompt.sh")]
            } else {
                []
            }
        )
    )

    $candidates | where {|p| $p | path exists } | get 0? | default ""
}

let __git_prompt_script = (__resolve_git_prompt_script)

def __prompt_git []: nothing -> string {
    if ($__git_prompt_script | is-empty) {
        return ""
    }

    let bash_script = '
        GIT_PS1_DESCRIBE_STYLE="branch"
        GIT_PS1_SHOWCONFLICTSTATE="yes"
        GIT_PS1_SHOWSTASHSTATE=1
        GIT_PS1_SHOWUPSTREAM="verbose"
        GIT_PS1_STATESEPARATOR=" "
        . "$1"
        __git_ps1 "%s"
    '

    let result = (
        do --ignore-errors { ^bash -c $bash_script -- $__git_prompt_script }
        | complete
    )

    if $result.exit_code != 0 {
        return ""
    }

    $result.stdout | str trim
}

def __prompt_extras []: nothing -> string {
    mut extras = ""

    let git_info = (__prompt_git)
    if ($git_info | is-not-empty) {
        $extras += $" (ansi blue_bold)[($git_info)]"
    }

    # Python virtual environments are so fun
    if ($env.VIRTUAL_ENV? | is-not-empty) {
        $extras += $" (ansi magenta_bold)[($env.VIRTUAL_ENV | path basename)]"
    }

    if (which kubectl | is-not-empty) {
        let kube_info = (do --ignore-errors { kubectl prompt ' > ' } | complete)
        if $kube_info.exit_code == 0 {
            $extras += $" (ansi cyan_bold)[($kube_info.stdout | str trim)]"
        }
    }

    $extras
}

$env.PROMPT_COMMAND = {||
    let last_exit_code = $env.LAST_EXIT_CODE
    let jobs = (__prompt_jobs)
    let time = (__prompt_time)
    let user = (whoami)
    let host = (__prompt_host)
    let base = ($env.PWD | path basename)
    let cwd = if ($base | is-empty) { $env.PWD } else { $base }

    (
        $"(ansi red_bold) [($last_exit_code) ($jobs) ($time)]"
        + $"(ansi green_bold) [($user)@($host)]"
        + $"(ansi yellow_bold) [($cwd)]"
        + (__prompt_extras)
        + $"(ansi reset)\n"
    )
}

$env.PROMPT_INDICATOR = {||
    if (is-admin) {
        $"(ansi attr_bold)# (ansi reset)"
    } else {
        $"(ansi attr_bold)$ (ansi reset)"
    }
}
