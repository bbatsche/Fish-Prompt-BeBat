function fish_prompt
    set -l last_status $status
    set -l prompt_hostname (echo $hostname | cut -d . -f 1)
    set -l prompt_date (date "+%-m.%-d.%Y %-I.%M %p" | tr '[:upper:]' '[:lower:]')

    switch $USER
        case root
            set user_color (set_color -o red )
            set arrow_color (set_color red)

        case '*'
            set user_color (set_color -o yellow )
            set arrow_color (set_color white)
    end

    echo -n -s (set_color normal) "⎡ " $user_color $USER (set_color white) "@" (set_color cyan) $prompt_hostname (set_color white) ":" (set_color -o green) (prompt_pwd) (set_color normal) " ("

    if [ $last_status = 0 ]
        set_color white
        echo -n -s " ✔︎ "
    else
        set_color red
        echo -n -s  " ✘ "
    end

    echo -s (set_color normal) ") [" (set_color white) $prompt_date (set_color normal) "]"

    echo -n -s (set_color normal) "⎣ ("

    switch $fish_bind_mode
        case default
            set_color --bold red
            echo -n "N"
        case insert
            set_color --bold white
            echo -n "I"
        case replace_one
            set_color --bold green
            echo -n 'R'
        case visual
            set_color --bold --background magenta white
            echo -n "V"
        case '*'
            set_color --bold red
            echo '?'
    end

    set_color normal

    echo -n -s ")" $arrow_color "➤ "

    set_color normal
end
