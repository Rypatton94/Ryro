#!/bin/bash
# Compatible with macOS's bundled Bash 3.2. No extra dependencies.
set -euo pipefail
export LC_ALL=C

usage() {
  cat <<'EOF'
Usage: bash scripts/rename-tile-images.sh [--apply] IMAGE_FOLDER

Preview by default. Add --apply to rename matching IMG_* image files to
"piece 0.EXT", "piece 1.EXT", etc., in filename order, keeping extensions.
Only files directly inside IMAGE_FOLDER are considered; folders and symlinks
are skipped. Existing destination files are never overwritten.
Applying also saves the original-to-new mapping in rename-manifest.csv.
EOF
}

apply=false
if [[ ${1:-} == --help || ${1:-} == -h ]]; then
  usage
  exit 0
fi
if [[ ${1:-} == --apply ]]; then
  apply=true
  shift
fi
if [[ $# -ne 1 || ! -d $1 ]]; then
  usage >&2
  exit 1
fi

directory=$(cd -- "$1" && pwd -P)
sources=()
destinations=()
shopt -s nullglob nocaseglob nocasematch

for source in "$directory"/IMG_*; do
  [[ -f $source && ! -L $source ]] || continue
  case "$source" in
    *.heic|*.heif|*.jpg|*.jpeg|*.png|*.tif|*.tiff|*.webp|*.avif|*.gif|*.bmp)
      sources+=("$source")
      extension=${source##*.}
      destinations+=("$directory/piece $((${#sources[@]} - 1)).$extension")
      ;;
  esac
done

if [[ ${#sources[@]} -eq 0 ]]; then
  printf 'No matching IMG_* image files in %s\n' "$directory"
  exit 0
fi

# Check the entire plan before changing any files.
for ((i = 0; i < ${#sources[@]}; i++)); do
  destination=${destinations[$i]}
  # A piece ID must also be unique across different image extensions.
  for existing in "${destination%.*}" "${destination%.*}".*; do
    if [[ -e $existing || -L $existing ]]; then
      printf 'Cannot rename: piece name already exists: %s\n' "$existing" >&2
      exit 1
    fi
  done
  printf '%s -> %s\n' "${sources[$i]##*/}" "${destination##*/}"
done

if [[ $apply == false ]]; then
  printf '\nPreview only. Run again with --apply to rename these %s files.\n' "${#sources[@]}"
  exit 0
fi

manifest="$directory/rename-manifest.csv"
if [[ -e $manifest || -L $manifest ]]; then
  printf 'Cannot rename: mapping file already exists: %s\n' "$manifest" >&2
  exit 1
fi

# Save the full plan before renaming, using exclusive file creation.
# If a move fails, this remains the planned mapping; earlier moves may be done.
(
  set -o noclobber
  {
    printf 'original_name,piece_name\n'
    for ((i = 0; i < ${#sources[@]}; i++)); do
      original=${sources[$i]##*/}
      renamed=${destinations[$i]##*/}
      original=${original//\"/\"\"}
      renamed=${renamed//\"/\"\"}
      printf '"%s","%s"\n' "$original" "$renamed"
    done
  } > "$manifest"
)

for ((i = 0; i < ${#sources[@]}; i++)); do
  source=${sources[$i]}
  destination=${destinations[$i]}
  if ! mv -n "$source" "$destination" || [[ -e $source || -L $source ]]; then
    printf 'Stopped at %s. Earlier files may have been renamed; consult %s.\n' "$source" "$manifest" >&2
    exit 1
  fi
done

printf '\nRenamed %s files. Mapping saved to %s\n' "${#sources[@]}" "$manifest"
