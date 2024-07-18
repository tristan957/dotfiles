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

function prompt_time
    echo -n (date +%H:%M:%S)
end

function prompt_extras
    set -l PROMPT_EXTRAS ''

    if git rev-parse --quiet
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

function fish_prompt
    set -l last_status $status
    set -l cwd (prompt_pwd --dir-length=1)
    set -l user_char '$'
    if fish_is_root_user
        set user_char '#'
    end

    echo -ne "$(set_color --bold) \b$(tput setaf 208) \b[$last_status $(jobs --pid | wc --lines) $(prompt_time)] $(tput setaf 76) \b[$USER@$(hostname)] $(tput setaf 214) \b[$cwd]$(prompt_extras) \b$(tput sgr0)\n+ $user_char $(set_color normal)"
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

if command --query direnv
    direnv hook fish | source
end

if command --query zoxide
    zoxide init fish | source
end
