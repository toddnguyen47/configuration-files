function set_fish_prompt_pwd_dir_length
    set -l work_dir (pwd)
    # Cut the prompt if it exceeds 80 characters
    if test (string length $work_dir) -gt 80
        set -g fish_prompt_pwd_dir_length 3
    else
        set -g fish_prompt_pwd_dir_length 0
    end
end

function set_global_colors --description 'Set global variables for colors'
    if not set -q __fish_prompt_normal
        set -g __fish_prompt_normal (set_color normal)
    end

    if not set -q __fish_color_blue_bold
        set -g __fish_color_blue_bold (set_color -o blue)
    end

    if not set -q __fish_color_yellow_bold
        set -g __fish_color_yellow_bold (set_color -o yellow)
    end

    if not set -q __fish_color_bg_blue
        set -g __fish_color_bg_blue (set_color -b blue)
    end

    if not set -q __fish_color_bg_cyan
        set -g __fish_color_bg_cyan (set_color -b cyan)
    end
end

function fish_prompt --description 'Write out the prompt'
	  # Save the return status of the previous command
    set stat $status

    # Shorten the current working directory
    set_fish_prompt_pwd_dir_length

    set_global_colors

    # Set the color for the status depending on the value. `Green` is default for "OK" status,
    # but I like `normal` color better.
    #set __fish_color_status (set_color -o green)
    set __fish_color_status (set_color normal)
    set -l prompt_char "↳"
    if test $stat -gt 0
        set __fish_color_status (set_color -o red)
        set prompt_char "[$stat]"
    end

    # Set prompt
    set -l prompt_char_with_color \
      (printf '%s%s%s' $__fish_color_status $prompt_char $__fish_prompt_normal)

    switch "$USER"
        case root toor
            if not set -q __fish_prompt_cwd
                if set -q fish_color_cwd_root
                    set -g __fish_prompt_cwd (set_color $fish_color_cwd_root)
                else
                    set -g __fish_prompt_cwd (set_color $fish_color_cwd)
                end
            end

            printf '%s@%s %s%s%s# ' \
              $USER (prompt_hostname) \
              "$__fish_prompt_cwd" \
              (prompt_pwd) \
              "$__fish_prompt_normal"

        case '*'
            if not set -q __fish_prompt_cwd
                set -g __fish_prompt_cwd (set_color $fish_color_cwd)
            end

            printf '\n%s<< %s@%s ⌚ %s >>%s\n%s%s\n%s ' \
              "$__fish_color_yellow_bold" \
              $USER \
              (prompt_hostname) \
              (date "+%H:%M:%S") \
              "$__fish_prompt_normal" \
              "$__fish_prompt_cwd" \
              (prompt_pwd) \
              "$prompt_char_with_color"
    end
end

