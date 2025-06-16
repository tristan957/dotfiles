function glab_login_gitlab {
    # It looks like if we use the web login method, tokens will refresh
    # automatically.
    glab auth login --web
}

function glab_login_gnome {
    glab auth login --hostname gitlab.gnome.org --stdin \
        <<<"$(op --account my.1password.com read \
            op://Personal/yfez73tv5qvyqrhlqfswktjssu/credential)"
}

function glab_write_config {
    # We can't store this in stow because the GitLab team stores credentials in
    # the file.
    #
    # WTF!
    glab config set check_update false
    glab config set display_hyperlinks true
    glab config set git_protocol ssh
    glab config set glamour_style dark
}

function glab_setup {
    if ! command -v glab &>/dev/null; then
        builtin return
    fi

    glab_login_gitlab
    glab_login_gnome
    glab_write_config
}
