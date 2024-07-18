if not status is-interactive
    return
end

set -U fish_greeting
set -U fish_color_host
set -U fish_color_user

set -g __fish_git_prompt_describe_style 'branch'
set -U __fish_git_prompt_showcolorhints
# set -g __fish_git_prompt_showconflictstate 'yes'
set -U __fish_git_prompt_showdirtystate
set -g __fish_git_prompt_showstashstate 1
set -U __fish_git_prompt_showuntrackedfiles
set -g __fish_git_prompt_showupstream 'verbose'
set -g __fish_git_prompt_char_stateseparator ' '

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
        set PROMPT_EXTRAS "$PROMPT_EXTRAS $(tput setaf 105) \b$(basename "$VIRTUAL_ENV")"
    end

    if command --query "kubectl"
        set -l kubectl_curr_ctx (kubectl config current-context 2>/dev/null)
        if test $status -eq 0
            set -l kubectl_curr_ns (kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null)
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
set CONTAINER (test -f /run/.containerenv; echo $status)
function __prompt_host
    if test $CONTAINER -eq 0
        sed -n 's/^name="\(.*\)"$/\1/p' </run/.containerenv
    else
        hostname
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

    echo -ne "$(set_color --bold) \b$(tput setaf 208) \b[$last_status $(__prompt_jobs) $(__prompt_time)] $(tput setaf 76) \b[$USER@$(__prompt_host)] $(tput setaf 214) \b[$cwd]$(__prompt_extras) \b$(tput sgr0)\n+ $user_char $(set_color normal)"
end

if command --query nvim
    set -gx EDITOR nvim
    set -gx MANPAGER 'nvim +Man!'
    set -gx VISUAL nvim
else if command --query vim
    set -gx EDITOR vim
    set -gx VISUAL vim
else if command --query vi
    set -gx EDITOR vi
    set -gx VISUAL vi
else
    set -gx EDITOR nano
    set -gx VISUAL nano
end

# Octal Permissions
alias permissions="stat -c '%a %n'"

# ls folder color
alias ls='ls -v --indicator-style=slash --color=auto'

# Apply colors to commands
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

if command --query 'bw'
    if flatpak list --app --columns=application | grep --quiet com.bitwarden.desktop &>/dev/null
        alias bw='flatpak run --command=bw com.bitwarden.desktop'
    end
end

# shellcheck disable=2139
alias wget="wget --hsts-file=$XDG_CACHE_HOME/wget-hsts"

# How to port this to fish
# alias colors='(x=$(tput op) y=$(printf %76s);for i in {0..256};do o=00$i;echo -e ${o:${#o}-3:3} $(tput setaf $i;tput setab $i)${y// /=}$x;done)'

# Clear the current kubectl context
alias kubeclr='kubectl config unset current-context'
alias kubens='kubectl config set-context --current --namespace'

# Shut the copyright notice up
alias gdb='gdb --quiet'
alias rust-gdb='rust-gdb --quiet'
alias bc='bc --quiet'

alias zz='zoxide query --interactive'

# Pull new history
alias hpull='history merge'

if command --query direnv
    direnv hook fish | source
end

if command --query zoxide
    zoxide init fish | source
end
