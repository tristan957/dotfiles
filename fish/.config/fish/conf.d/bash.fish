# A simple version of history expansion - '!!' and '!$'
function histreplace
    switch "$argv[1]"
    case !!
        echo -- $history[1]
        return 0
    case '!$'
        echo -- $history[1] | read -lat tokens
        echo -- $tokens[-1]
        return 0
    case '^*^*'
        set -l kv (string split '^' -- $argv[1])
        or return
        # We replace the first occurence in each line
        # (collect is to inhibit the final newline)
        string split \n -- $history[1] | string replace -- $kv[2] $kv[3] | string collect
        return 0
    end

    return 1
end

abbr --add !! --function histreplace --position anywhere
abbr --add '!$' --function histreplace --position anywhere
abbr --add histreplace_regex --regex '\^.*\^.*' --function histreplace --position anywhere
