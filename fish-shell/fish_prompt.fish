# Ref: https://github.com/fish-shell/fish-shell/issues/3480
function shorten_hostname --description "Shorten the hostname"
        if not set -q __fish_prompt_hostname
                set -g __fish_prompt_hostname (hostname | cut -c 1-5)(echo ...)
        end
        #set -l color_dir cyan
        set -g fish_prompt_pwd_dir_length 0
end
