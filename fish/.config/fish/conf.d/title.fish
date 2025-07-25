function fish_title
    set -l cwd (prompt_pwd --dir-length=1)

    if set --query argv[1]
        echo $cwd: $argv
    else
        echo $cwd
    end
end
