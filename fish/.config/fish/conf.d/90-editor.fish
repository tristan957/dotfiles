if command --query nvim
    set -gx EDITOR nvim
else if command --query vim
    set -gx EDITOR vim
else if command --query vi
    set -gx EDITOR vi
else
    set -gx EDITOR nano
end
