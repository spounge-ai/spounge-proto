#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$SCRIPT_DIR/.."

# Clean generated dirs
rm -rf "$ROOT_DIR/gen/go"/*
rm -rf "$ROOT_DIR/gen/ts"/*

# Find all .proto files recursively under proto/
PROTO_FILES=$(find "$ROOT_DIR/proto" -name '*.proto')

# protoc requires proto paths relative to -I include, so make paths relative
PROTO_RELATIVE_FILES=()
for f in $PROTO_FILES; do
  # remove the root dir prefix + /proto/ to get relative path like common/v1/common.proto
  relative_path="${f#$ROOT_DIR/proto/}"
  PROTO_RELATIVE_FILES+=("$relative_path")
done

# Convert array to space-separated string
PROTO_FILES_ARG="${PROTO_RELATIVE_FILES[*]}"

echo "Generating Go protobuf code..."
protoc -I="$ROOT_DIR/proto" \
  --go_out="$ROOT_DIR/gen/go" --go_opt=paths=source_relative \
  --go-grpc_out="$ROOT_DIR/gen/go" --go-grpc_opt=paths=source_relative \
  $PROTO_FILES_ARG

echo "Generating TypeScript protobuf code..."
protoc -I="$ROOT_DIR/proto" \
  --plugin=protoc-gen-ts=$(which protoc-gen-ts) \
  --js_out=import_style=commonjs,binary:"$ROOT_DIR/gen/ts" \
  --ts_out="$ROOT_DIR/gen/ts" \
  $PROTO_FILES_ARG

echo "Generation completed."
