script_name="$(readlink -f $0)"
printf "Sourcing %s\n" "${script_name}"

path=(
  "/opt/bin"
  "$HOME/.cargo/bin"
  $path
)

export PATH
