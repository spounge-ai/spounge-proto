# stash: might use in the future, leaving it here in case different operations

#!/bin/bash
set -e

# Config
REPO_URL="github.com/spoungeai/spounge-proto"
TS_PKG_NAME="@spoungeai/protos-ts"
VERSION="0.1.0"

# Generate go.mod for gen/go
echo "Initializing go.mod in gen/go..."
cat > gen/go/go.mod <<EOF
module $REPO_URL/gen/go

go 1.24.1
EOF
echo "gen/go/go.mod created."

# Generate package.json for gen/ts
echo "Initializing package.json in gen/ts..."
cat > gen/ts/package.json <<EOF
{
  "name": "$TS_PKG_NAME",
  "version": "$VERSION",
  "main": "index.js",
  "types": "index.d.ts",
  "files": [
    "**/*.ts",
    "**/*.js",
    "**/*.d.ts",
    "!**/*.map"
  ],
  "scripts": {
    "prepublishOnly": "tsc"
  }
}
EOF
echo "gen/ts/package.json created."
