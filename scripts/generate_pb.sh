#!/bin/bash
set -e
source "$(dirname "${BASH_SOURCE[0]}")/spounge_prettier.sh"

# Parse input parameter for generation mode
MODE="$1"  # no param = both, "go" = go only, "ts" = ts only

print_header "🔧 PROTOBUF CODE GENERATOR"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$SCRIPT_DIR/.."

print_section "📋 SETUP & CLEANUP"
print_info "Script directory: ${SCRIPT_DIR}"
print_info "Root directory: ${ROOT_DIR}"

# Update buf dependencies
print_section "📦 UPDATING BUF DEPENDENCIES"
echo -e "${YELLOW}${GEAR} Running buf dep update...${NC}"
cd "$ROOT_DIR"
if ! buf dep update; then
    print_error "Failed to update buf dependencies"
    exit 1
fi
print_success "Buf dependencies updated"

# Create directories if they don't exist
echo -e "\n${YELLOW}${GEAR} Creating output directories...${NC}"
mkdir -p "$ROOT_DIR/gen/go"
mkdir -p "$ROOT_DIR/gen/ts"
mkdir -p "$ROOT_DIR/gen/openapi"
print_success "Output directories created"

# Clean generated dirs selectively based on mode
echo -e "\n${YELLOW}${GEAR} Cleaning existing generated files...${NC}"
if [ -z "$MODE" ]; then
  # no param = clean both
  rm -rf "$ROOT_DIR/gen/go"/*
  rm -rf "$ROOT_DIR/gen/ts"/*
  rm -rf "$ROOT_DIR/gen/openapi"/*
elif [ "$MODE" == "go" ]; then
  rm -rf "$ROOT_DIR/gen/go"/*
  rm -rf "$ROOT_DIR/gen/openapi"/*
elif [ "$MODE" == "ts" ]; then
  rm -rf "$ROOT_DIR/gen/ts"/*
fi
print_success "Generated directories cleaned"

# Generate code using buf generate
if [ -z "$MODE" ] || [ "$MODE" == "go" ]; then
  print_section "🐹 GENERATING GO CODE"
  echo -e "${YELLOW}${GEAR} Running buf generate for Go...${NC}"
  cd "$ROOT_DIR"
  
  # Create a temporary buf.gen.yaml for Go-only generation
  cat > buf.gen.go.yaml << 'EOF'
version: v2
clean: true
managed:
  enabled: true
  override:
    - file_option: go_package_prefix
      value: github.com/spounge-ai/spounge-proto/gen/go
plugins:
  - remote: buf.build/protocolbuffers/go
    out: gen/go
    opt:
      - paths=source_relative
  - remote: buf.build/grpc/go
    out: gen/go
    opt:
      - paths=source_relative
  - remote: buf.build/grpc-ecosystem/gateway
    out: gen/go
    opt:
      - paths=source_relative
  - remote: buf.build/connectrpc/go
    out: gen/go
    opt:
      - paths=source_relative
  - remote: buf.build/grpc-ecosystem/openapiv2
    out: gen/openapi
    opt:
      - logtostderr=true
inputs:
  - directory: proto
  - module: buf.build/googleapis/googleapis
EOF
  
  if ! buf generate --template buf.gen.go.yaml; then
    print_error "Failed to generate Go code"
    rm -f buf.gen.go.yaml
    exit 1
  fi
  
  # Clean up temporary file
  rm -f buf.gen.go.yaml
  print_success "Go protobuf generation complete"

  # --- Ensure go.mod exists in gen/go ---
  GO_MOD_FILE="$ROOT_DIR/gen/go/go.mod"
  if [ ! -f "$GO_MOD_FILE" ]; then
    cat > "$GO_MOD_FILE" << 'EOF'
module github.com/spounge-ai/spounge-proto/gen/go

go 1.24.1

require (
  google.golang.org/protobuf v1.34.2
  google.golang.org/grpc v1.65.0
  connectrpc.com/connect v1.16.2
  github.com/grpc-ecosystem/grpc-gateway/v2 v2.22.0
  google.golang.org/genproto/googleapis/api v0.0.0-20240814211410-ddb44dafa142
)
EOF
    print_info "Created go.mod in gen/go"
  else
    print_info "go.mod already exists in gen/go"
  fi

 

  # Run go mod tidy to update dependencies to latest compatible versions
  cd "$ROOT_DIR/gen/go" && go mod tidy
  print_success "Go modules tidied in gen/go"
fi

# Generate TypeScript code using buf generate for consistency
if [ -z "$MODE" ] || [ "$MODE" == "ts" ]; then
  print_section "🔷 GENERATING TYPESCRIPT CODE"
  echo -e "${YELLOW}${GEAR} Running buf generate for TypeScript...${NC}"
  
  cd "$ROOT_DIR"
  
  # Create a temporary buf.gen.yaml for TypeScript-only generation
  # IMPORTANT: Include googleapis in inputs to generate google/api types
  cat > buf.gen.ts.yaml << 'EOF'
version: v2
clean: true
managed:
  enabled: true
plugins:
  - remote: buf.build/bufbuild/es
    out: gen/ts
    opt:
      - target=ts
      - import_extension=none
inputs:
  - directory: proto
  - module: buf.build/googleapis/googleapis
EOF
  
  if ! buf generate --template buf.gen.ts.yaml; then
    print_error "Failed to generate TypeScript code"
    rm -f buf.gen.ts.yaml
    exit 1
  fi
  
  # Clean up temporary file
  rm -f buf.gen.ts.yaml
  print_success "TypeScript generation complete"

  # Fix TypeScript import paths to remove .js extensions
  echo -e "\n${YELLOW}${GEAR} Fixing TypeScript import paths...${NC}"
  find "$ROOT_DIR/gen/ts" -name "*.ts" -type f -exec sed -i 's|from "\(.*\)\.js"|from "\1"|g' {} \;
  find "$ROOT_DIR/gen/ts" -name "*.ts" -type f -exec sed -i "s|from '\(.*\)\.js'|from '\1'|g" {} \;
  print_success "TypeScript import paths fixed"

  # Run the TypeScript imports script to create proper index files
  echo -e "\n${YELLOW}${GEAR} Generating TypeScript index files...${NC}"
  if [ -f "$SCRIPT_DIR/ts_imports.sh" ]; then
    bash "$SCRIPT_DIR/ts_imports.sh"
    print_success "TypeScript index files generated"
  else
    print_error "ts_imports.sh not found in $SCRIPT_DIR"
  fi

  # Generate TypeScript package.json
  echo -e "\n${YELLOW}${GEAR} Generating TypeScript package.json...${NC}"
  if [ -f "$SCRIPT_DIR/update_ts_package.js" ]; then
    node "$SCRIPT_DIR/update_ts_package.js"
    print_success "TypeScript package.json generated"
  else
    print_error "update_ts_package.js not found in $SCRIPT_DIR"
  fi
fi

# Show generated files
print_section "📊 GENERATED FILES SUMMARY"

if [ -z "$MODE" ] || [ "$MODE" == "go" ]; then
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
fi

if [ -z "$MODE" ] || [ "$MODE" == "ts" ]; then
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
fi

# Update Go modules only if Go generation ran
if [ -z "$MODE" ] || [ "$MODE" == "go" ]; then
  print_section "📦 UPDATING GO MODULES"
  echo -e "${YELLOW}${GEAR} Running go mod tidy in gen/go...${NC}"
  cd "$ROOT_DIR/gen/go" && go mod tidy
  print_success "Go modules updated successfully in gen/go"
fi

# Final summary
print_header "🎉 GENERATION COMPLETE"
echo -e "${GREEN}${ROCKET} All protobuf code has been generated successfully!${NC}"
echo -e "\n${WHITE}Summary:${NC}"

if [ -z "$MODE" ] || [ "$MODE" == "go" ]; then
  echo -e "${GREEN}  ${CHECK} Generated ${GO_FILES:-0} Go file(s)${NC}"
fi

if [ -z "$MODE" ] || [ "$MODE" == "ts" ]; then
  echo -e "${GREEN}  ${CHECK} Generated ${TS_FILES:-0} TypeScript file(s)${NC}"
fi

if [ -z "$MODE" ] || [ "$MODE" == "go" ]; then
  echo -e "${GREEN}  ${CHECK} Updated Go modules${NC}"
fi

echo -e "\n${CYAN}${ARROW} Generated files are located in:${NC}"
if [ -z "$MODE" ] || [ "$MODE" == "go" ]; then
  echo -e "${PURPLE}  ${FOLDER} $ROOT_DIR/gen/go/${NC}"
fi
if [ -z "$MODE" ] || [ "$MODE" == "ts" ]; then
  echo -e "${PURPLE}  ${FOLDER} $ROOT_DIR/gen/ts/${NC}"
fi

echo -e "\n${BLUE}═══════════════════════════════════════════════════════════════${NC}\n"