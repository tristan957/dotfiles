function bitwarden_login {
    mkdir "$XDG_CONFIG_HOME/bitwarden"
    session_key=$(flatpak run --command="bw" com.bitwarden.desktop --raw login)
    echo "$session_key" | gpg2 --symmetric --output "$XDG_CONFIG_HOME/bitwarden/session-key.txt"
}

function bitwarden_setup {
    bitwarden_login
}
