#!/bin/bash

set -e

# Source prettier helpers (assuming helpers.sh is in the same directory or adjust path)
source "$(dirname "${BASH_SOURCE[0]}")/spounge_prettier.sh"

# Configuration
TS_GEN_DIR="gen/ts"
TEMP_DIR=$(mktemp -d)

# Clean up temp directory on exit
trap "rm -rf $TEMP_DIR" EXIT

# Get all TypeScript files that contain utility types
get_utility_types() {
    local file="$1"
    grep -o "export.*\(DeepPartial\|Exact\|MessageFns\|protobufPackage\)" "$file" 2>/dev/null | head -1 || true
}

# Find the first file with utility types (becomes the source)
find_utility_source() {
    find "$TS_GEN_DIR" -name "*.ts" -not -name "index.ts" | while read -r file; do
        if get_utility_types "$file" >/dev/null 2>&1; then
            echo "$file"
            return
        fi
    done | head -1
}

# Get main exported types from a TypeScript file (excluding utility types)
get_main_exports() {
    local file="$1"
    # Extract export statements but exclude utility types
    grep -E "^export (interface|class|type|const|enum|function)" "$file" 2>/dev/null | \
    grep -v -E "(DeepPartial|Exact|MessageFns|protobufPackage)" | \
    sed -E 's/^export (interface|class|type|const|enum|function) ([A-Za-z0-9_]+).*/\2/' | \
    sort | uniq
}

# Function to create index file for a directory
create_index() {
    local dir="$1"
    local index_file="$dir/index.ts"
    local relative_path="${dir#$TS_GEN_DIR/}"

    # Skip if no TypeScript files exist
    if ! find "$dir" -maxdepth 1 -name "*.ts" -not -name "index.ts" | grep -q .; then
        return
    fi

    # Create temporary index file
    local temp_index="$TEMP_DIR/$(echo "$relative_path" | tr '/' '_').index.ts"

    # Special handling for google/protobuf directory
    if [[ "$relative_path" == "google/protobuf" ]]; then
        # Export utilities from first file only
        local first_file=$(find "$dir" -maxdepth 1 -name "*.ts" -not -name "index.ts" | head -1)
        if [[ -n "$first_file" ]]; then
            local first_basename=$(basename "$first_file" .ts)
            echo "export * from './$first_basename';" >> "$temp_index"
        fi

        # Export only the main types from other files
        find "$dir" -maxdepth 1 -name "*.ts" -not -name "index.ts" | tail -n +2 | while read -r file; do
            local basename=$(basename "$file" .ts)
            local main_type="$(echo "${basename:0:1}" | tr '[:lower:]' '[:upper:]')${basename:1}"
            echo "export { $main_type } from './$basename';" >> "$temp_index"
        done
    else
        # For directories with multiple files, export utilities from first file only
        local files=($(find "$dir" -maxdepth 1 -name "*.ts" -not -name "index.ts" | sort))
        local utility_source_file=""
        
        # Find which file has utility types
        for file in "${files[@]}"; do
            if get_utility_types "$file" >/dev/null 2>&1; then
                utility_source_file="$file"
                break
            fi
        done

        # If we have multiple files in the directory, handle utilities specially
        if [[ ${#files[@]} -gt 1 && -n "$utility_source_file" ]]; then
            # Export everything from the utility source file
            local utility_basename=$(basename "$utility_source_file" .ts)
            echo "export * from './$utility_basename';" >> "$temp_index"
            
            # For other files, export only non-utility types
            for file in "${files[@]}"; do
                if [[ "$file" != "$utility_source_file" ]]; then
                    local basename=$(basename "$file" .ts)
                    local main_exports=$(get_main_exports "$file")
                    
                    if [[ -n "$main_exports" ]]; then
                        # Export specific types, excluding utilities
                        echo "$main_exports" | while read -r export_name; do
                            if [[ -n "$export_name" ]]; then
                                echo "export { $export_name } from './$basename';" >> "$temp_index"
                            fi
                        done
                    else
                        # Fallback: try to export everything except utilities
                        echo "export * from './$basename';" >> "$temp_index"
                    fi
                fi
            done
        else
            # Single file or no utilities found - use normal export
            for file in "${files[@]}"; do
                local basename=$(basename "$file" .ts)
                echo "export * from './$basename';" >> "$temp_index"
            done
        fi
    fi

    # Export subdirectories that have TypeScript content
    find "$dir" -mindepth 1 -maxdepth 1 -type d | while read -r subdir; do
        if find "$subdir" -name "*.ts" | grep -q .; then
            local basename=$(basename "$subdir")
            echo "export * from './$basename';" >> "$temp_index"
        fi
    done

    # Only update if content changed or file doesn't exist
    if [[ ! -f "$index_file" ]] || ! cmp -s "$temp_index" "$index_file"; then
        mv "$temp_index" "$index_file"
        print_success "Updated: $index_file"
    fi
}

# Create namespace-aware root index
create_root_index() {
    local root_index="$TS_GEN_DIR/index.ts"
    local temp_root="$TEMP_DIR/root.index.ts"

    # Find utility source for re-export
    local utility_source=$(find_utility_source)
    local utility_module=""

    if [[ -n "$utility_source" ]]; then
        # Convert absolute path to relative module path
        utility_module=$(echo "${utility_source#$TS_GEN_DIR/}" | sed 's/\.ts$//' | sed 's/\/index$//')

        # Export utility types from single source
        cat >> "$temp_root" << EOF
// Re-export utility types from single source to avoid conflicts
export type { DeepPartial, Exact, MessageFns } from './$utility_module';
export { protobufPackage } from './$utility_module';

EOF
    fi

    # Export all top-level directories
    find "$TS_GEN_DIR" -mindepth 1 -maxdepth 1 -type d | sort | while read -r dir; do
        if find "$dir" -name "*.ts" | grep -q .; then
            local basename=$(basename "$dir")
            echo "export * from './$basename';" >> "$temp_root"
        fi
    done

    # Update only if changed
    if [[ ! -f "$root_index" ]] || ! cmp -s "$temp_root" "$root_index"; then
        mv "$temp_root" "$root_index"
        print_success "Updated: $root_index"
    fi
}

# Main execution

if [[ ! -d "$TS_GEN_DIR" ]]; then
    print_error "Error: $TS_GEN_DIR directory not found"
    exit 1
fi

print_header "Generating TypeScript index files..."

# Process directories from deepest to shallowest
find "$TS_GEN_DIR" -type d | sort -r | while read -r dir; do
    create_index "$dir"
done

print_section "Creating intermediate directory indexes..."
find "$TS_GEN_DIR" -mindepth 1 -maxdepth 1 -type d | while read -r dir; do
    basename=$(basename "$dir")
    index_file="$dir/index.ts"

    # Only create if doesn't exist and has subdirectories with content
    if [[ ! -f "$index_file" ]]; then
        find "$dir" -mindepth 1 -maxdepth 1 -type d | while read -r subdir; do
            if find "$subdir" -name "*.ts" | grep -q .; then
                sub_basename=$(basename "$subdir")
                echo "export * from './$sub_basename';" >> "$index_file"
            fi
        done

        if [[ -f "$index_file" ]]; then
            print_success "Created: $index_file"
        fi
    fi
done

print_section "Creating root index with namespace resolution..."
create_root_index

print_section "Fixing common protobuf issues..."

# Fix import statements and default exports
find "$TS_GEN_DIR" -name "*.ts" -not -name "index.ts" -exec sed -i.bak -E \
    -e "s/from ['\"](.+)\.js['\"]/from '\1'/g" \
    -e "s/export default ([^;]+);/export const \1 = \1;/g" \
    {} \;

# Clean up backup files
find "$TS_GEN_DIR" -name "*.bak" -delete

print_success "TypeScript index files generated successfully"