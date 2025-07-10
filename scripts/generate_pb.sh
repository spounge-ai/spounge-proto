#!/bin/bash
set -e

# Colors for pretty output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Unicode symbols
CHECK="✅"
CROSS="❌"
ARROW="➜"
BULLET="•"
FOLDER="📁"
FILE="📄"
GEAR="⚙️"
ROCKET="🚀"

# Helper functions
print_header() {
    echo -e "\n${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${WHITE}  $1${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}\n"
}

print_section() {
    echo -e "\n${CYAN}${ARROW} $1${NC}"
    echo -e "${CYAN}───────────────────────────────────────────────────────────────${NC}"
}

print_success() {
    echo -e "${GREEN}${CHECK} $1${NC}"
}

print_error() {
    echo -e "${RED}${CROSS} $1${NC}"
}

print_info() {
    echo -e "${YELLOW}${BULLET} $1${NC}"
}

print_file() {
    echo -e "${PURPLE}  ${FILE} $1${NC}"
}

# Main script starts here
print_header "🔧 PROTOBUF CODE GENERATOR"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$SCRIPT_DIR/.."

print_section "📋 SETUP & CLEANUP"
print_info "Script directory: ${SCRIPT_DIR}"
print_info "Root directory: ${ROOT_DIR}"

# Create directories if they don't exist
echo -e "\n${YELLOW}${GEAR} Creating output directories...${NC}"
mkdir -p "$ROOT_DIR/gen/go"
mkdir -p "$ROOT_DIR/gen/ts"
print_success "Output directories created"

# Clean generated dirs
echo -e "\n${YELLOW}${GEAR} Cleaning existing generated files...${NC}"
rm -rf "$ROOT_DIR/gen/go"/*
rm -rf "$ROOT_DIR/gen/ts"/*
print_success "Generated directories cleaned"

# Find all .proto files recursively under proto/
print_section "🔍 DISCOVERING PROTO FILES"
PROTO_FILES=$(find "$ROOT_DIR/proto" -name '*.proto')

if [ -z "$PROTO_FILES" ]; then
    print_error "No .proto files found in $ROOT_DIR/proto"
    echo -e "\n${RED}Please ensure your .proto files are located in the proto/ directory${NC}\n"
    exit 1
fi

# Count total files
TOTAL_FILES=$(echo "$PROTO_FILES" | wc -l)
print_success "Found ${TOTAL_FILES} proto file(s)"

# protoc requires proto paths relative to -I include, so make paths relative
PROTO_RELATIVE_FILES=()
for f in $PROTO_FILES; do
  relative_path="${f#$ROOT_DIR/proto/}"
  PROTO_RELATIVE_FILES+=("$relative_path")
done

PROTO_FILES_ARG="${PROTO_RELATIVE_FILES[*]}"

echo -e "\n${WHITE}📋 Proto files to process:${NC}"
for file in "${PROTO_RELATIVE_FILES[@]}"; do
  print_file "$file"
done

# Generate Go code
print_section "🐹 GENERATING GO CODE"
echo -e "${YELLOW}${GEAR} Running protoc for Go...${NC}"
protoc -I="$ROOT_DIR/proto" \
  --go_out="$ROOT_DIR/gen/go" --go_opt=paths=source_relative \
  --go-grpc_out="$ROOT_DIR/gen/go" --go-grpc_opt=paths=source_relative \
  $PROTO_FILES_ARG
print_success "Go protobuf generation complete"

# Generate TypeScript code
print_section "🔷 GENERATING TYPESCRIPT CODE"
echo -e "${YELLOW}${GEAR} Running protoc for TypeScript...${NC}"
protoc -I="$ROOT_DIR/proto" \
  --plugin=protoc-gen-ts_proto=./node_modules/.bin/protoc-gen-ts_proto \
  --ts_proto_out="$ROOT_DIR/gen/ts" \
  --ts_proto_opt=esModuleInterop=true,forceLong=long,useOptionals=messages \
  $PROTO_FILES_ARG
print_success "TypeScript generation complete"

# Show generated files
print_section "📊 GENERATED FILES SUMMARY"

echo -e "\n${WHITE}${FOLDER} Go files generated:${NC}"
GO_FILES=$(find "$ROOT_DIR/gen/go" -name "*.go" -type f | wc -l)
if [ "$GO_FILES" -gt 0 ]; then
    print_info "Total Go files: ${GO_FILES}"
    find "$ROOT_DIR/gen/go" -name "*.go" -type f | head -10 | while read -r file; do
        print_file "${file#$ROOT_DIR/}"
    done
    if [ "$GO_FILES" -gt 10 ]; then
        echo -e "${PURPLE}    ... and $((GO_FILES - 10)) more files${NC}"
    fi
else
    print_error "No Go files were generated"
fi

echo -e "\n${WHITE}${FOLDER} TypeScript files generated:${NC}"
TS_FILES=$(find "$ROOT_DIR/gen/ts" -name "*.ts" -type f | wc -l)
if [ "$TS_FILES" -gt 0 ]; then
    print_info "Total TypeScript files: ${TS_FILES}"
    find "$ROOT_DIR/gen/ts" -name "*.ts" -type f | head -10 | while read -r file; do
        print_file "${file#$ROOT_DIR/}"
    done
    if [ "$TS_FILES" -gt 10 ]; then
        echo -e "${PURPLE}    ... and $((TS_FILES - 10)) more files${NC}"
    fi
else
    print_error "No TypeScript files were generated"
fi

# Update Go modules
print_section "📦 UPDATING GO MODULES"
echo -e "${YELLOW}${GEAR} Running go mod tidy...${NC}"
cd "$ROOT_DIR" && go mod tidy
print_success "Go modules updated successfully"

# Final summary
print_header "🎉 GENERATION COMPLETE"
echo -e "${GREEN}${ROCKET} All protobuf code has been generated successfully!${NC}"
echo -e "\n${WHITE}Summary:${NC}"
echo -e "${GREEN}  ${CHECK} Processed ${TOTAL_FILES} proto file(s)${NC}"
echo -e "${GREEN}  ${CHECK} Generated ${GO_FILES} Go file(s)${NC}"
echo -e "${GREEN}  ${CHECK} Generated ${TS_FILES} TypeScript file(s)${NC}"
echo -e "${GREEN}  ${CHECK} Updated Go modules${NC}"
echo -e "\n${CYAN}${ARROW} Generated files are located in:${NC}"
echo -e "${PURPLE}  ${FOLDER} $ROOT_DIR/gen/go/${NC}"
echo -e "${PURPLE}  ${FOLDER} $ROOT_DIR/gen/ts/${NC}"
echo -e "\n${BLUE}═══════════════════════════════════════════════════════════════${NC}\n"