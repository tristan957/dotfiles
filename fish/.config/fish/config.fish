if not status is-interactive
    return
end

function __fish_update_cwd_osc --on-variable PWD --description 'Notify terminals when $PWD changes'
    printf \e\]7\;file://%s%s\a $hostname (string escape --style=url -- $PWD)
end

__fish_update_cwd_osc # Run once because we might have already inherited a PWD from an old

set -U fish_greeting
