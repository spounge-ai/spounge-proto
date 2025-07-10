.PHONY: generate clean build test tag-release

# Generate protobuf files
generate:
	@echo "Generating protobuf files..."
	@./scripts/generate.sh

# Clean generated files
clean:
	@echo "Cleaning generated files..."
	@rm -rf gen/go/*
	@rm -rf gen/ts/*

# Build and test
build:
	@echo "Building Go module..."
	@go build ./...

test:
	@echo "Running tests..."
	@go test ./...

# Lint proto files (requires buf)
lint:
	@echo "Linting proto files..."
	@buf lint

# Check if generated files are up to date
check-generated:
	@echo "Checking if generated files are up to date..."
	@git diff --exit-code gen/ || (echo "Generated files are out of date. Run 'make generate'" && exit 1)

# Tag a new release
tag-release:
	@echo "Current tags:"
	@git tag -l | sort -V | tail -5
	@echo "Enter new version (e.g., v1.0.0):"
	@read VERSION && git tag $$VERSION && git push origin $$VERSION

# Install required tools
install-tools:
	@echo "Installing required tools..."
	@go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
	@go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
	@npm install -g ts-protoc-gen

# Help
help:
	@echo "Available commands:"
	@echo "  make generate       - Generate protobuf files"
	@echo "  make clean          - Clean generated files"
	@echo "  make build          - Build Go module"
	@echo "  make test           - Run tests"
	@echo "  make lint           - Lint proto files"
	@echo "  make check-generated - Check if generated files are up to date"
	@echo "  make tag-release    - Tag a new release"
	@echo "  make install-tools  - Install required tools"