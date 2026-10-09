# A simple version of history expansion - '!!' and '!$'
function histreplace
    switch "$argv[1]"
    case !!
        echo -- $history[1]
        return 0
    case !#
        set -l tokens (string split ' ' -- $history[1])
        echo -- $tokens[-1]
        return 0
    case '^*^*'
        string match --regex '^\^([^^]*)\^(.*)' -- $argv[1] | read -l _ old new
        or return
        string split \n -- $history[1] | string replace -- $old $new | string collect
        return 0
    end

    return 1
end

abbr --add !! --function histreplace --position anywhere
abbr --add !# --function histreplace --position anywhere
abbr --add histreplace_regex --regex '\^.*\^.*' --function histreplace --position anywhere
