#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$SCRIPT_DIR/.."
TS_DIR="$ROOT_DIR/gen/ts"

if [ ! -d "$TS_DIR" ]; then
    echo "❌ TypeScript directory not found: $TS_DIR"
    exit 1
fi

echo "🔍 Analyzing TypeScript imports in $TS_DIR..."

# Extract external imports (not relative paths)
IMPORTS=$(grep -rho "import.*from ['\"].*['\"]" "$TS_DIR" 2>/dev/null | \
    grep -v "\./" | \
    sed "s/.*from ['\"]//g" | \
    sed "s/['\"].*//g" | \
    sed 's/\/.*$//' | \
    sort -u)

if [ -z "$IMPORTS" ]; then
    echo "✅ No external imports found"
    exit 0
fi

echo "📦 Found external imports:"
echo "$IMPORTS" | sed 's/^/  - /'

echo ""
echo "🛠️  Suggested npm install commands:"
echo "$IMPORTS" | while read -r pkg; do
    echo "npm install $pkg"
done

echo ""
echo "🔧 Or install all at once:"
echo -n "npm install "
echo "$IMPORTS" | tr '\n' ' '
echo

# Check if packages are already installed
echo ""
echo "📋 Installation status:"
echo "$IMPORTS" | while read -r pkg; do
    if [ -d "$ROOT_DIR/node_modules/$pkg" ]; then
        echo "  ✅ $pkg (installed)"
    else
        echo "  ❌ $pkg (missing)"
    fi
done