# These are copied from robbyrussell"s theme
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}[ git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=" ]%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

# Reset RPROMPT
RPROMPT=''

# Ref: http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Prompt-Expansion
prompt_char="%(!.#.$)"
prompt_char_error="%(!.#.✘)"

# Reset background and foreground
PROMPT='%{%f%b%k%}'

# Get current working dir
PROMPT+='%{$fg_bold[cyan]%}%~'

# User
PROMPT+='%b%{$fg[yellow]%} [%n]'

# Time
PROMPT+='%{$fg[default]%} ⌚ %T'

# Git status. NEED to use single quotes to preserve the literal value of each character!
# Ref: https://stackoverflow.com/a/6697781
PROMPT+='
$(git_prompt_info)'

# Now prompt char! Turns the prompt char red and into `✘` if there was an error
PROMPT+='%(?.%{$fg[default]%}$prompt_char.%{$fg_bold[red]%}$prompt_char_error)'

# Reset all colors and add a space after the prompt
PROMPT+='%{$reset_color%} '

