function fish_title
    set -l cwd (prompt_pwd --dir-length=1)

    switch "$(uname)"
    case Darwin
        if set --query argv[1]
            echo (whoami)@(prompt_hostname):$cwd: $argv
        else
            echo (whoami)@(prompt_hostname):$cwd
        end
    case '*'
        if set --query argv[1]
            echo (whoami)@(prompt_hostname): $argv
        else
            echo (whoami)@(prompt_hostname)
        end
    end
end
