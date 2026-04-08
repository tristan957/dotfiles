set -gx LESS R
set -gx LESSHISTSIZE 1000000
set -gx LESSOPEN '| pygmentize -O style=one-dark %s 2>/dev/null'
