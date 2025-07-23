#!/bin/bash
set -euo pipefail  # Stricter error handling

# Source the spounge_prettier.sh script for helper functions and colors
source "$(dirname "${BASH_SOURCE[0]}")/spounge_prettier.sh"
# Parse input parameter for generation mode
MODE="${1:-py}"  # Default to python only if no param provided

print_header "🔧 PYTHON PROTOBUF + gRPC CODE GENERATOR"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$SCRIPT_DIR/.."

# >>>> Define the output path in one place <<<<
PY_OUT_DIR="$ROOT_DIR/gen/py/spounge"

print_section "📋 SETUP & VALIDATION"
print_info "Script directory: ${SCRIPT_DIR}"
print_info "Root directory: ${ROOT_DIR}"
print_info "Generation mode: ${MODE}"

# Validate buf is installed
if ! command -v buf &> /dev/null; then
    print_error "buf is not installed. Please install it from https://docs.buf.build/installation"
    exit 1
fi

# Validate proto directory exists
if [ ! -d "$ROOT_DIR/proto" ]; then
    print_error "Proto directory not found: $ROOT_DIR/proto"
    exit 1
fi

# Update buf dependencies
print_section "📦 UPDATING BUF DEPENDENCIES"
echo -e "${YELLOW}${GEAR} Running buf dep update...${NC}"
cd "$ROOT_DIR"
if ! buf dep update; then
    print_error "Failed to update buf dependencies"
    exit 1
fi
print_success "Buf dependencies updated"

# Create output directory
echo -e "\n${YELLOW}${GEAR} Creating output directories...${NC}"
mkdir -p "$PY_OUT_DIR"
print_success "Output directories created"

# Clean generated dirs
echo -e "\n${YELLOW}${GEAR} Cleaning existing generated files...${NC}"
if [ "$MODE" == "py" ] || [ -z "$MODE" ]; then
    find "$PY_OUT_DIR" -name "*.py" -delete 2>/dev/null || true
    find "$PY_OUT_DIR" -name "__pycache__" -type d -exec rm -rf {} + 2>/dev/null || true
fi
print_success "Generated directories cleaned"

# Generate Python code
if [ "$MODE" == "py" ] || [ -z "$MODE" ]; then
    print_section "🐍 GENERATING PYTHON PROTOBUF + gRPC CODE"
    echo -e "${YELLOW}${GEAR} Running buf generate for Python...${NC}"
    cd "$ROOT_DIR"

    # Temp generation config
    cat > buf.gen.py.yaml <<EOF
version: v2
clean: true
managed:
  enabled: true
plugins:
  - remote: buf.build/protocolbuffers/python:v31.1
    out: ${PY_OUT_DIR#"$ROOT_DIR"/}
  - remote: buf.build/grpc/python:v1.73.1
    out: ${PY_OUT_DIR#"$ROOT_DIR"/}
inputs:
  - directory: proto
  - module: buf.build/googleapis/googleapis
EOF

    if ! buf generate --template buf.gen.py.yaml; then
        print_error "Failed to generate Python code"
        rm -f buf.gen.py.yaml
        exit 1
    fi
    rm -f buf.gen.py.yaml
    print_success "Python protobuf + gRPC generation complete"

    # Create __init__.py files
    print_section "📦 CREATING PACKAGE STRUCTURE"
    echo -e "${YELLOW}${GEAR} Creating __init__.py files...${NC}"
    touch "$ROOT_DIR/gen/py/__init__.py"
    find "$PY_OUT_DIR" -type d -exec touch {}/__init__.py \;
    print_success "Package structure created"

    # Format the code
    print_section "💅 FORMATTING PYTHON CODE"
    echo -e "${YELLOW}${GEAR} Formatting generated Python files...${NC}"

    if command -v ruff &> /dev/null; then
        echo -e "${CYAN}Using ruff for formatting...${NC}"
        ruff format "$PY_OUT_DIR" --config line-length=88 --quiet 2>/dev/null || true
        ruff check "$PY_OUT_DIR" --fix --quiet 2>/dev/null || true
        print_success "Python files formatted and linted with ruff"
    elif command -v black &> /dev/null; then
        echo -e "${CYAN}Using black for formatting...${NC}"
        black "$PY_OUT_DIR" --quiet 2>/dev/null || true
        if command -v isort &> /dev/null; then
            isort "$PY_OUT_DIR" --quiet 2>/dev/null || true
            print_success "Python files formatted with black + isort"
        else
            print_success "Python files formatted with black"
        fi
    else
        print_info "No formatter found. Install ruff ('pip install ruff') for best results"
    fi

    # Type check
    if command -v mypy &> /dev/null; then
        print_section "🔍 TYPE CHECKING (OPTIONAL)"
        echo -e "${YELLOW}${GEAR} Running mypy type checking...${NC}"
        if mypy "$PY_OUT_DIR" --ignore-missing-imports --quiet 2>/dev/null; then
            print_success "Type checking passed"
        else
            print_info "Type checking found some issues (non-critical)"
        fi
    fi
fi

# Summary
print_section "📊 GENERATED FILES SUMMARY"

if [ "$MODE" == "py" ] || [ -z "$MODE" ]; then
    echo -e "\n${WHITE}${FOLDER} Python files generated:${NC}"
    PROTO_FILES=$(find "$PY_OUT_DIR" -name "*_pb2.py" -type f | wc -l)
    GRPC_FILES=$(find "$PY_OUT_DIR" -name "*_pb2_grpc.py" -type f | wc -l)
    TOTAL_FILES=$(find "$PY_OUT_DIR" -name "*.py" -type f ! -name "__init__.py" | wc -l)
    INIT_FILES=$(find "$ROOT_DIR/gen/py" -name "__init__.py" -type f | wc -l)

    print_info "Protobuf message files (*_pb2.py): ${PROTO_FILES}"
    print_info "gRPC service files (*_pb2_grpc.py): ${GRPC_FILES}" 
    print_info "Package __init__.py files: ${INIT_FILES}"
    print_info "Total Python files: ${TOTAL_FILES}"

    if [ "$TOTAL_FILES" -gt 0 ]; then
        echo -e "\n${CYAN}Sample generated files:${NC}"
        mapfile -t SAMPLE_FILES < <(find "$PY_OUT_DIR" -name "*.py" -type f ! -name "__init__.py" | head -8)
        for file in "${SAMPLE_FILES[@]}"; do
            print_file "${file#$ROOT_DIR/}"
        done
        if [ "$TOTAL_FILES" -gt 8 ]; then
            echo -e "${PURPLE}    ... and $((TOTAL_FILES - 8)) more files${NC}"
        fi
    else
        print_error "No Python files were generated"
        exit 1
    fi
fi

# Final output
print_header "🎉 GENERATION COMPLETE"
echo -e "${GREEN}${ROCKET} All protobuf and gRPC code has been generated successfully!${NC}"
echo -e "\n${WHITE}Summary:${NC}"

if [ "$MODE" == "py" ] || [ -z "$MODE" ]; then
    echo -e "${GREEN}  ${CHECK} Generated ${PROTO_FILES:-0} protobuf message file(s)${NC}"
    echo -e "${GREEN}  ${CHECK} Generated ${GRPC_FILES:-0} gRPC service file(s)${NC}"
    echo -e "${GREEN}  ${CHECK} Created ${INIT_FILES:-0} package __init__.py file(s)${NC}"
fi

echo -e "\n${CYAN}${ARROW} Generated files are located in:${NC}"
if [ "$MODE" == "py" ] || [ -z "$MODE" ]; then
    echo -e "${PURPLE}  ${FOLDER} $PY_OUT_DIR${NC}"
fi

echo -e "\n${YELLOW}${GEAR} Next steps:${NC}"
echo -e "${WHITE}  1. Install required Python packages:${NC}"
echo -e "${CYAN}     pip install grpcio grpcio-tools protobuf${NC}"
echo -e "${WHITE}  2. Import in your Python code:${NC}"
echo -e "${CYAN}     from spounge.your_service import your_service_pb2, your_service_pb2_grpc${NC}"

echo -e "\n${BLUE}═══════════════════════════════════════════════════════════════${NC}\n"
