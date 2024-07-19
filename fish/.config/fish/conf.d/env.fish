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
