function add_pkg_config_path --description "Add paths to PKG_CONFIG_PATH, skipping duplicates"
    argparse p/prepend a/append -- $argv
    or return 1

    set -l mode append
    if set -q _flag_prepend
        set mode prepend
    end

    for path in $argv
        contains -- $path $PKG_CONFIG_PATH; and continue
        switch $mode
            case prepend
                set -gx --path PKG_CONFIG_PATH $path $PKG_CONFIG_PATH
            case append
                set -gxa --path PKG_CONFIG_PATH $path
        end
    end
end
