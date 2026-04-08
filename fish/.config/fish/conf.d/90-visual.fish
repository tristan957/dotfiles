if command --query nvim
    set -gx VISUAL nvim
else if command --query vim
    set -gx VISUAL vim
else if command --query vi
    set -gx VISUAL vi
else
    set -gx VISUAL nano
end
