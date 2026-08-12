function fish_title
    set -l host (prompt_hostname)
    set -l cwd (prompt_pwd --dir-length=1)

    switch (uname)
    case Darwin
        if set --query argv[1]
            echo $USER@$host:$cwd: $argv
        else
            echo $USER@$host:$cwd
        end
    case '*'
        if set --query argv[1]
            echo $USER@$host: $argv
        else
            echo $USER@$host
        end
    end
end
