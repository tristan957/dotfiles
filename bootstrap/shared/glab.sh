function glab_login_gitlab {
    # glab auth login --stdin \
    #     <<<"$(op --account my.1password.com read \
    #         op://Personal/ez4tbwlk7knw74qhh5ym7gtid4/credential)"

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
    glab config set git_protocol ssh
    glab config set glamour_style dark
    glab config set check_update false
    glab config set display_hyperlinks true
}

function glab_setup {
    glab_login_gitlab
    glab_login_gnome
    glab_write_config
}
