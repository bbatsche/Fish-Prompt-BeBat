function fish_title
    set -l prompt_hostname (echo $hostname | cut -d . -f 1)

    echo -s (prompt_pwd) " ($prompt_hostname)"
end
