# Autoload all functions in $HOME/.oh-my-zsh/functions
function_folder="$HOME/.oh-my-zsh/functions"
mkdir -p $function_folder
for file in $function_folder/*; do
  printf "Autoloading %s\n" $file
  autoload $file
done

# Load init
autoload -Uz compinit

# Must be last
compinit -i
