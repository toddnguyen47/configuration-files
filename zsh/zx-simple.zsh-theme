# Inspired by `robbyrussell` and 'agnoster' theme
# Documentation here: http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
# Ref for root: https://askubuntu.com/a/707654

prompt_char() {
  printf "%s%s" \
    "%(?.%{$reset_color%}.%{$fg_bold[red]%})" \
    "%(?."$"."✘")"
}

insert_space() {
  printf " "
}

reset_bg_fg_color() {
  printf "%s" "%{%f%b%k%}"
}

current_directory() {
  printf "%s%s" \
    "%{$fg_bold[cyan]%}" \
    "%/"
}

user_name() {
  printf "%s[%s]" \
    "%{$fg_bold[yellow]%}" \
    "%n"
}

current_time() {
  printf "%s ⌚ %s" \
    %{$reset_color%} \
    "%T"
}

build_prompt() {
  reset_bg_fg_color
  current_directory
  insert_space
  user_name
  insert_space
  current_time
}


# Reset background and foreground before building a prompt
PROMPT='$(build_prompt)
$(git_prompt_info)$(prompt_char)%{$reset_color%} '

# These are copied from robbyrussell's theme
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}[ git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=" ]%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
