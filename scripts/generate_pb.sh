#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$SCRIPT_DIR/.."

# Create directories if they don't exist
mkdir -p "$ROOT_DIR/gen/go"
mkdir -p "$ROOT_DIR/gen/ts"

# Clean generated dirs
rm -rf "$ROOT_DIR/gen/go"/*
rm -rf "$ROOT_DIR/gen/ts"/*

# Find all .proto files recursively under proto/
PROTO_FILES=$(find "$ROOT_DIR/proto" -name '*.proto')

if [ -z "$PROTO_FILES" ]; then
    echo "No .proto files found in $ROOT_DIR/proto"
    exit 1
fi

# protoc requires proto paths relative to -I include, so make paths relative
PROTO_RELATIVE_FILES=()
for f in $PROTO_FILES; do
  # remove the root dir prefix + /proto/ to get relative path like common/v1/common.proto
  relative_path="${f#$ROOT_DIR/proto/}"
  PROTO_RELATIVE_FILES+=("$relative_path")
done

# Convert array to space-separated string
PROTO_FILES_ARG="${PROTO_RELATIVE_FILES[*]}"

echo "Found proto files: ${PROTO_FILES_ARG}"

echo "Generating Go protobuf code..."
protoc -I="$ROOT_DIR/proto" \
  --go_out="$ROOT_DIR/gen/go" --go_opt=paths=source_relative \
  --go-grpc_out="$ROOT_DIR/gen/go" --go-grpc_opt=paths=source_relative \
  $PROTO_FILES_ARG

echo "Generating TypeScript code with ts-proto..."
protoc -I="$ROOT_DIR/proto" \
  --plugin=protoc-gen-ts_proto=./node_modules/.bin/protoc-gen-ts_proto \
  --ts_proto_out="$ROOT_DIR/gen/ts" \
  --ts_proto_opt=esModuleInterop=true,forceLong=long,useOptionals=true \
  $PROTO_FILES_ARG

echo "Generation completed."

# Verify generated files
echo "Generated Go files:"
find "$ROOT_DIR/gen/go" -name "*.go" -type f | head -10

echo "Generated TypeScript files:"
find "$ROOT_DIR/gen/ts" -name "*.ts" -type f | head -10

# Run go mod tidy to ensure dependencies are correct
echo "Running go mod tidy..."
cd "$ROOT_DIR" && go mod tidy

echo "✅ Proto generation and module update complete!"