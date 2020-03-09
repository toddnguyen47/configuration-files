# Ref: http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Prompt-Expansion

# These are copied from robbyrussell"s theme
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}[ git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=" ]%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

# Reset background and foreground
PROMPT="%{%f%b%k%}"

# Get current working dir
PROMPT+="%{$fg_bold[cyan]%}%/"

# User
PROMPT+="%b%{$fg[yellow]%} [%n]"

# Time
PROMPT+="%{$fg[default]%} ⌚%T"

# Git status
PROMPT+="
$(git_prompt_info)"

# Now prompt char! Turns the prompt char red if there was an error
PROMPT+="%(?.%{$fg[default]%}.%{$fg_bold[red]%})$%{$reset_color%} "

