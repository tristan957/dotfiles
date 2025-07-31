function fish_title
    set -l cwd (prompt_pwd --dir-length=1)

    switch (uname)
    case Darwin
        if set --query argv[1]
            echo $cwd: $argv
        else
            echo $cwd
        end
    case '*'
        if set --query argv[1]
            echo $argv
        else
            echo $cwd
        end
    end
end
