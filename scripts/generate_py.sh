#!/bin/bash
set -e

# Source the spounge_prettier.sh script for helper functions and colors
source "$(dirname "${BASH_SOURCE[0]}")/spounge_prettier.sh"


# Parse input parameter for generation mode
MODE="$1"  # no param = python only, "py" = python only

print_header "🔧 PYTHON PROTOBUF CODE GENERATOR"

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
fi
print_success "Buf dependencies updated"

# Create directories if they don't exist
echo -e "\n${YELLOW}${GEAR} Creating output directories...${NC}"
mkdir -p "$ROOT_DIR/gen/py"
print_success "Output directories created"

# Clean generated dirs selectively based on mode
echo -e "\n${YELLOW}${GEAR} Cleaning existing generated files...${NC}"
CLEAN_DIRS=()
if [ -z "$MODE" ] || [ "$MODE" == "py" ]; then
  CLEAN_DIRS+=("$ROOT_DIR/gen/py")
fi

for dir in "${CLEAN_DIRS[@]}"; do
  rm -rf "$dir"/*
done
print_success "Generated directories cleaned"


# Generate Python code using buf generate
if [ -z "$MODE" ] || [ "$MODE" == "py" ]; then
  print_section "🐍 GENERATING PYTHON CODE"
  echo -e "${YELLOW}${GEAR} Running buf generate for Python...${NC}"
  cd "$ROOT_DIR"
  
  # Create a temporary buf.gen.py.yaml for Python-only generation
  cat > buf.gen.py.yaml << 'EOF'
version: v2
clean: true
managed:
  enabled: true
plugins:
  - remote: buf.build/protocolbuffers/python
    out: gen/py
    opt:
      - grpc
      - mypy
      - mypy_grpc
inputs:
  - directory: proto
  - module: buf.build/googleapis/googleapis
EOF
  
  if ! buf generate --template buf.gen.py.yaml; then
    print_error "Failed to generate Python code"
    rm -f buf.gen.py.yaml
    exit 1
  fi
  
  # Clean up temporary file
  rm -f buf.gen.py.yaml
  print_success "Python protobuf generation complete"

  # --- Add Black formatting step ---
  print_section "💅 FORMATTING PYTHON CODE WITH BLACK"
  echo -e "${YELLOW}${GEAR} Running black on generated Python files...${NC}"
  # Check if black is installed
  if command -v black &> /dev/null
  then
      # Run black on the generated Python directory
      black "$ROOT_DIR/gen/py"
      print_success "Python files formatted successfully with Black"
  else
      print_error "Black is not installed. Please install it with 'pip install black' to format Python files."
  fi
  # --- End of Black formatting step ---
fi

# Show generated files
print_section "📊 GENERATED FILES SUMMARY"

if [ -z "$MODE" ] || [ "$MODE" == "py" ]; then
  echo -e "\n${WHITE}${FOLDER} Python files generated:${NC}"
  PY_FILES=$(find "$ROOT_DIR/gen/py" -name "*.py" -type f | wc -l)
  if [ "$PY_FILES" -gt 0 ]; then
      print_info "Total Python files: ${PY_FILES}"
      find "$ROOT_DIR/gen/py" -name "*.py" -type f | head -10 | while read -r file; do
          print_file "${file#$ROOT_DIR/}"
      done
      if [ "$PY_FILES" -gt 10 ]; then
          echo -e "${PURPLE}    ... and $((PY_FILES - 10)) more files${NC}"
      fi
  else
      print_error "No Python files were generated"
  fi
fi

# Final summary
print_header "🎉 GENERATION COMPLETE"
echo -e "${GREEN}${ROCKET} All protobuf code has been generated successfully!${NC}"
echo -e "\n${WHITE}Summary:${NC}"

if [ -z "$MODE" ] || [ "$MODE" == "py" ]; then
  echo -e "${GREEN}  ${CHECK} Generated ${PY_FILES:-0} Python file(s)${NC}"
fi

echo -e "\n${CYAN}${ARROW} Generated files are located in:${NC}"
if [ -z "$MODE" ] || [ "$MODE" == "py" ]; then
  echo -e "${PURPLE}  ${FOLDER} $ROOT_DIR/gen/py/${NC}"
fi

echo -e "\n${BLUE}═══════════════════════════════════════════════════════════════${NC}\n"
