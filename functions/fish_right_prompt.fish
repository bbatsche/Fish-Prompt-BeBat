set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_hide_untrackedfiles 1

set -g __fish_git_prompt_color_branch -o magenta
set -g __fish_git_prompt_showupstream "informative"
set -g __fish_git_prompt_char_upstream_ahead "↑"
set -g __fish_git_prompt_char_upstream_behind "↓"
set -g __fish_git_prompt_char_upstream_prefix ""

set -g __fish_git_prompt_char_stagedstate "●"
set -g __fish_git_prompt_char_dirtystate "✚"
set -g __fish_git_prompt_char_untrackedfiles "…"
set -g __fish_git_prompt_char_conflictedstate "✖"
set -g __fish_git_prompt_char_cleanstate "✔"

set -g __fish_git_prompt_color_dirtystate blue
set -g __fish_git_prompt_color_stagedstate yellow
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
set -g __fish_git_prompt_color_cleanstate -o green

function fish_right_prompt
    if hg id > /dev/null ^ /dev/null
        set hg_clean (set_color -o green)"✔"
        set hg_status (set_color magenta)(hg prompt "{update}{status|modified|unknown}" ^ /dev/null)
        set hg_outgoing (set_color cyan)(hg prompt "{↑{outgoing|count}}" ^ /dev/null)
        set hg_incoming (set_color blue)(hg prompt "{↓{incoming|count}}" ^ /dev/null)

        echo -n -s $__fish_prompt_normal "("

        set_color white

        hg prompt "{branch}" ^ /dev/null

        echo -n -s $__fish_prompt_normal ":"

        if [ $hg_status ]
            echo -n -s $hg_status
        else
            echo -n -s $hg_clean

            if test -n "$hg_outgoing" -o -n "$hg_incoming"
                echo -n " "
            end
        end

        echo -n -s $hg_outgoing $hg_incoming

        echo -n -s $__fish_prompt_normal ")"
    end

    echo -n -s (__fish_git_prompt)
end
