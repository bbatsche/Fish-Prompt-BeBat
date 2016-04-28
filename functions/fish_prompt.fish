function fish_vi_prompt_cm --description "Displays the current mode"
  echo "("
  switch $fish_bind_mode
    case default
      set_color --bold red
      echo "N"
    case insert
      set_color --bold white
      echo "I"
    case visual
      set_color --bold --background magenta white
      echo "V"
  end
  set_color normal
  echo ")"
end

function fish_prompt
    set -l last_status $status

    # Just calculate these once, to save a few cycles when displaying the prompt
    if not set -q __fish_prompt_hostname
        set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
    end

    if not set -q __fish_prompt_normal
        set -g __fish_prompt_normal (set_color normal)
    end

    switch $USER
        case root
            if not set -q __fish_prompt_user_color
                set -g __fish_prompt_user_color (set_color -o red )
            end

            if not set -q __fish_prompt_arrow_color
                set -g __fish_prompt_arrow_color (set_color red)
            end
        case '*'
            if not set -q __fish_prompt_user_color
                set -g __fish_prompt_user_color (set_color -o yellow )
            end

            if not set -q __fish_prompt_arrow_color
                set -g __fish_prompt_arrow_color (set_color white)
            end
    end

    echo -n -s $__fish_prompt_normal "⎡ " $__fish_prompt_user_color "$USER"

    set_color white

    echo -n "@"

    set_color cyan

    echo -n "$__fish_prompt_hostname"

    set_color white

    echo -n ":"

    set_color -o green

    echo -n (prompt_pwd) $__fish_prompt_normal"("

    if [ $last_status = 0 ]
        set_color white
        echo -n -s " ✔︎ "
    else
        set_color red
        echo -n -s  " ✘ "
    end

    echo -n -s $__fish_prompt_normal ") ["

    set_color white

    set __fish_prompt_date (date "+%-m.%-d.%Y %-I.%M %p" | tr '[:upper:]' '[:lower:]')

    echo -s $__fish_prompt_date $__fish_prompt_normal "]"

    echo -n -s $__fish_prompt_normal "⎣ " (fish_vi_prompt_cm) $__fish_prompt_arrow_color "➤ " $__fish_prompt_normal
end
