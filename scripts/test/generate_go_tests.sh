#!/bin/bash

# scripts/generate_go_tests.sh
# Dynamically generates Go tests by parsing generated protobuf files.

set -e

# --- Configuration ---
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
GEN_GO_DIR="$ROOT_DIR/gen/go"
TEST_GO_DIR="$ROOT_DIR/tests/go"
SPONGE_PRETTIER="$ROOT_DIR/scripts/spounge_prettier.sh"

# --- Source helper functions ---
if [ -f "$SPONGE_PRETTIER" ]; then
    source "$SPONGE_PRETTIER"
else
    # Define fallback functions if prettier is not found
    print_header() { echo -e "\n═══════════════════════════════════════════════════════════════\n  $1\n═══════════════════════════════════════════════════════════════\n"; }
    print_section() { echo -e "\n➜ $1\n───────────────────────────────────────────────────────────────"; }
    print_info() { echo "• $1"; }
    print_success() { echo "✅ $1"; }
    print_file() { echo "  📄 $1"; }
    print_error() { echo "❌ ERROR: $1"; }
fi

# --- Helper Functions ---

# Get Go version and module name from the generated go.mod
get_go_dependencies() {
    local go_mod_file="$GEN_GO_DIR/go.mod"
    if [[ ! -f "$go_mod_file" ]]; then
        print_error "go.mod not found in $GEN_GO_DIR. Please run 'make gen-go' first."
        exit 1
    fi
    local go_version=$(grep -m1 "^go " "$go_mod_file" | awk '{print $2}')
    local module_name=$(grep -m1 "^module " "$go_mod_file" | awk '{print $2}')
    echo "GO_VERSION=${go_version:-1.21}"
    echo "MODULE_NAME=${module_name}"
}

# Initialize the test module
init_test_module() {
    local module_name="$1"
    local go_version="$2"
    
    # Use a distinct module name to avoid nested module issues
    cat > "$TEST_GO_DIR/go.mod" << EOF
module ${module_name}-tests

go ${go_version}

require (
    ${module_name} v0.0.0
    github.com/stretchr/testify v1.8.4
    google.golang.org/grpc v1.60.1
    google.golang.org/protobuf v1.32.0
)

replace ${module_name} => ../../gen/go
EOF
}

# Parse Go files to find messages, services, and enums
parse_go_protobuf() {
    local proto_file="$1"
    local messages=$(grep -oP 'type \K([A-Z][a-zA-Z0-9_]*)(?= struct \{)' "$proto_file" | sort -u || true)
    local services=$(grep -oP 'type \K([A-Z][a-zA-Z0-9_]*Client)(?= interface)' "$proto_file" | sed 's/Client$//' | sort -u || true)
    local enums=$(grep -oP 'type \K([A-Z][a-zA-Z0-9_]*)(?= int32)' "$proto_file" | sort -u || true)
    
    messages=$(echo "$messages" | tr '\n' ' ')
    services=$(echo "$services" | tr '\n' ' ')
    enums=$(echo "$enums" | tr '\n' ' ')

    echo "MESSAGES='$messages'"
    echo "SERVICES='$services'"
    echo "ENUMS='$enums'"
}

# Generate tests for messages and enums
generate_message_tests() {
    local package_path="$1"
    local messages="$2"
    local enums="$3"
    local test_file="$4"
    local module_name="$5"

    if [ -z "$messages" ] && [ -z "$enums" ]; then return; fi
    
    local package_name=$(basename "$package_path")
    
    cat > "$test_file" << EOF
package ${package_name}_test

import (
    "testing"
    "google.golang.org/protobuf/proto"
    "github.com/stretchr/testify/assert"
    pb "${module_name}/${package_path}"
)
EOF

    for msg in $messages; do
        cat >> "$test_file" << EOF

func Test${msg}_Message(t *testing.T) {
    m := &pb.${msg}{}
    assert.NotNil(t, m, "Message should not be nil after initialization")
    m.Reset()
    assert.Equal(t, &pb.${msg}{}, m, "Message should be zero-valued after reset")
    assert.Implements(t, (*proto.Message)(nil), m, "Should implement proto.Message")
}
EOF
    done

    for enum in $enums; do
        cat >> "$test_file" << EOF

func Test${enum}_Enum(t *testing.T) {
    e := pb.${enum}(0)
    assert.NotEmpty(t, e.String(), "String representation should not be empty")
}
EOF
    done
}

# Generate tests for services
generate_service_tests() {
    local package_path="$1"
    local services="$2"
    local test_file="$3"
    local module_name="$4"

    if [ -z "$services" ]; then return; fi

    local package_name=$(basename "$package_path")
    
    cat > "$test_file" << EOF
package ${package_name}_test

import (
    "context"
    "net"
    "testing"
    "google.golang.org/grpc"
    "google.golang.org/grpc/credentials/insecure"
    "google.golang.org/grpc/test/bufconn"
    "github.com/stretchr/testify/assert"
    "github.com/stretchr/testify/require"
    pb "${module_name}/${package_path}"
)
EOF

    for service in $services; do
        cat >> "$test_file" << EOF

func Test${service}Client_Initialization(t *testing.T) {
    lis := bufconn.Listen(1024 * 1024)
    t.Cleanup(func() { lis.Close() })

    conn, err := grpc.DialContext(context.Background(), "bufnet", grpc.WithContextDialer(func(context.Context, string) (net.Conn, error) {
        return lis.Dial()
    }), grpc.WithTransportCredentials(insecure.NewCredentials()))
    require.NoError(t, err)
    t.Cleanup(func() { conn.Close() })

    client := pb.New${service}Client(conn)
    assert.NotNil(t, client, "Client should be successfully created")
}
EOF
    done
}

# --- Main Execution ---

main() {
    print_header "🐹 Go Test Generator"
    
    print_section "📋 SETUP & CLEANUP"
    if [[ -d "$TEST_GO_DIR" ]]; then
        print_info "Cleaning existing test directory: $TEST_GO_DIR"
        rm -rf "$TEST_GO_DIR"
    fi
    mkdir -p "$TEST_GO_DIR"
    print_success "Created test directory: $TEST_GO_DIR"

    if [[ ! -d "$GEN_GO_DIR" || -z "$(ls -A "$GEN_GO_DIR")" ]]; then
        print_error "Generated Go directory ($GEN_GO_DIR) is empty. Please run 'make gen-go' first."
        exit 1
    fi
    
    print_section "📦 INITIALIZING GO TEST MODULE"
    local deps_info
    deps_info=$(get_go_dependencies)
    eval "$deps_info"
    init_test_module "$MODULE_NAME" "$GO_VERSION"
    print_success "Initialized Go module for testing"
    
    print_section "🔍 DISCOVERING GENERATED GO FILES"
    local go_files=$(find "$GEN_GO_DIR" -type f \( -name "*.pb.go" -o -name "*_grpc.pb.go" \))
    if [ -z "$go_files" ]; then
        print_error "No generated Go files found to test in $GEN_GO_DIR"
        exit 1
    fi
    local total_files=$(echo "$go_files" | wc -l | xargs)
    print_success "Found ${total_files} generated Go file(s) to analyze"

    print_section "🧪 GENERATING TEST FILES"
    echo "$go_files" | while read -r proto_file; do
        local relative_dir=$(dirname "${proto_file#$GEN_GO_DIR/}")
        if [[ "$relative_dir" == "." ]]; then continue; fi
        
        local test_dir="$TEST_GO_DIR/$relative_dir"
        mkdir -p "$test_dir"

        print_info "Processing: ${proto_file#$ROOT_DIR/}"
        
        local parse_info
        parse_info=$(parse_go_protobuf "$proto_file")
        eval "$parse_info"
        
        local msg_test_file="$test_dir/$(basename "$relative_dir")_messages_test.go"
        generate_message_tests "$relative_dir" "$MESSAGES" "$ENUMS" "$msg_test_file" "$MODULE_NAME"
        if [ -f "$msg_test_file" ]; then
            print_file "Generated: ${msg_test_file#$ROOT_DIR/}"
        fi

        local svc_test_file="$test_dir/$(basename "$relative_dir")_services_test.go"
        generate_service_tests "$relative_dir" "$SERVICES" "$svc_test_file" "$MODULE_NAME"
        if [ -f "$svc_test_file" ]; then
            print_file "Generated: ${svc_test_file#$ROOT_DIR/}"
        fi
    done

    print_section "📦 UPDATING GO TEST MODULE"
    (cd "$TEST_GO_DIR" && go mod tidy > /dev/null 2>&1)
    print_success "Go module dependencies tidied for the test suite"

    print_header "🎉 GENERATION COMPLETE"
    echo "Go tests have been generated in '$TEST_GO_DIR'."
    echo "You can now run them using the 'make test-go' command."
}

main "$@"