#!/bin/bash
set -euo pipefail

ROOT_DIR="."
ORG_NAME="Spounge"
BUF_FILE="buf.yaml"

declare -a modules=()

# Find directories exactly 3 levels deep that contain .proto files
mapfile -t proto_dirs < <(find "$ROOT_DIR" -mindepth 3 -maxdepth 3 -type f -name '*.proto' -printf '%h\n' | sort -u)

for dir in "${proto_dirs[@]}"; do
  # e.g. spounge-protos/polykey/v1 -> polykey
  service_name=$(echo "$dir" | cut -d'/' -f2)
  if [[ -z "$service_name" ]]; then
    echo "Warning: Could not extract service name from $dir"
    continue
  fi

  mod_name="${service_name}-protos"

  # Avoid duplicates if proto files exist in multiple version folders for same service
  if [[ ! " ${modules[*]} " =~ " ${mod_name} " ]]; then
    modules+=("$mod_name")
  fi
done

# Write buf.yaml
{
  echo "version: v2"
  echo "modules:"
  for mod in "${modules[@]}"; do
    # Assume the path is spounge-protos/<service>/v1 (or any version)
    service_dir="$ROOT_DIR/${mod%-protos}/v1"
    echo "  - path: $service_dir"
    echo "    name: buf.build/$ORG_NAME/$mod"
  done
  echo "lint:"
  echo "  use:"
  echo "    - STANDARD"
  echo "breaking:"
  echo "  use:"
  echo "    - FILE"
} > "$BUF_FILE"

echo "Generated $BUF_FILE with ${#modules[@]} modules."