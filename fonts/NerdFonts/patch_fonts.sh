#!/usr/bin/env bash
# Run font-patcher on every .ttf file in a folder.
#
# Usage:
#   ./patch-fonts.sh --input FOLDER --output FOLDER [--patcher PATH] [extra font-patcher args...]
#
# Examples:
#   ./patch-fonts.sh --input ~/fonts --output ~/fonts/patched
#   ./patch-fonts.sh -i ~/fonts -o ~/fonts/patched --complete
#   ./patch-fonts.sh --input=~/fonts --output=./out --patcher ~/nerd-fonts/font-patcher
#
# Any arguments the script doesn't recognize (e.g. --complete) are passed to font-patcher.
# The output folder is created if it doesn't exist.

set -uo pipefail

usage() {
  cat >&2 <<USAGE
Usage: $(basename "$0") --input FOLDER --output FOLDER [--patcher PATH] [extra font-patcher args...]

  -i, --input FOLDER     folder containing .ttf files
  -o, --output FOLDER    folder to write patched fonts to (created if missing)
  -p, --patcher PATH     path to font-patcher (default: ./font-patcher)
  -h, --help             show this help

Unrecognized arguments (e.g. --complete) are passed through to font-patcher.
USAGE
  exit "${1:-1}"
}

INPUT=""
OUT_DIR=""
FONT_PATCHER="${FONT_PATCHER:-./font-patcher}"
EXTRA=()

need_value() { # $1 = flag name, $2 = number of remaining args
  if (($2 < 2)); then
    echo "Error: $1 requires a value" >&2
    usage
  fi
}

while (($# > 0)); do
  case "$1" in
  -i | --input)
    need_value "$1" $#
    INPUT="$2"
    shift 2
    ;;
  --input=*)
    INPUT="${1#*=}"
    shift
    ;;
  -o | --output)
    need_value "$1" $#
    OUT_DIR="$2"
    shift 2
    ;;
  --output=*)
    OUT_DIR="${1#*=}"
    shift
    ;;
  -p | --patcher)
    need_value "$1" $#
    FONT_PATCHER="$2"
    shift 2
    ;;
  --patcher=*)
    FONT_PATCHER="${1#*=}"
    shift
    ;;
  -h | --help) usage 0 ;;
  --)
    shift
    EXTRA+=("$@")
    break
    ;;
  *)
    EXTRA+=("$1")
    shift
    ;;
  esac
done

# Expand a leading ~ in --flag=~/path forms (the shell doesn't expand it there)
INPUT="${INPUT/#\~/$HOME}"
OUT_DIR="${OUT_DIR/#\~/$HOME}"
FONT_PATCHER="${FONT_PATCHER/#\~/$HOME}"

[[ -n "$INPUT" ]] || {
  echo "Error: --input is required" >&2
  usage
}
[[ -n "$OUT_DIR" ]] || {
  echo "Error: --output is required" >&2
  usage
}

if [[ ! -d "$INPUT" ]]; then
  echo "Error: input '$INPUT' is not a directory" >&2
  exit 1
fi

if [[ ! -f "$FONT_PATCHER" ]]; then
  echo "Error: font-patcher not found at '$FONT_PATCHER' (use --patcher PATH)" >&2
  exit 1
fi

if ! mkdir -p "$OUT_DIR"; then
  echo "Error: could not create output folder '$OUT_DIR'" >&2
  exit 1
fi

shopt -s nullglob nocaseglob # no match -> empty list; match .ttf and .TTF
fonts=("$INPUT"/*.ttf)
shopt -u nocaseglob

if ((${#fonts[@]} == 0)); then
  echo "No .ttf files found in '$INPUT'"
  exit 0
fi

echo "Input:   $INPUT"
echo "Output:  $OUT_DIR"
echo "Patcher: $FONT_PATCHER"
((${#EXTRA[@]} > 0)) && echo "Extra:   ${EXTRA[*]}"
echo

ok=0
failed=()

for font in "${fonts[@]}"; do
  echo "==> Patching: $font"
  if fontforge -script "$FONT_PATCHER" "$font" --outputdir "$OUT_DIR" ${EXTRA[@]+"${EXTRA[@]}"}; then
    ((ok++))
  else
    echo "!! Failed: $font" >&2
    failed+=("$font")
  fi
done

echo
echo "Done: $ok succeeded, ${#failed[@]} failed (of ${#fonts[@]})."
if ((${#failed[@]} > 0)); then
  printf '  failed: %s\n' "${failed[@]}"
  exit 1
fi
