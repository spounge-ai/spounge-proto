.PHONY: generate clean build test tag-release gen gen-go gen-ts lint check-generated install-tools help docker-build docker-gen-go docker-gen-ts docker-gen check-generated-docker

# --- Existing targets ---

generate: gen

gen: gen-go gen-ts

gen-go:
	@echo "Generating Go protobuf files..."
	@chmod +x scripts/generate_pb.sh
	@./scripts/generate_pb.sh go

gen-ts:
	@echo "Generating TypeScript protobuf files..."
	@chmod +x scripts/generate_pb.sh
	@./scripts/generate_pb.sh ts

ts-imports:
	@echo "Getting TypeScript imports..."
	@chmod +x scripts/ts_imports.sh
	@./scripts/ts_imports.sh

clean:
	@echo "Cleaning generated files..."
	@rm -rf gen/go/*
	@rm -rf gen/ts/*

build:
	@echo "Building Go module..."
	@go build ./...

test:
	@echo "Running tests..."
	@go test ./...

lint:
	@echo "Linting proto files..."
	@buf lint

init-pkg:
	@echo "Packaging Go and Ts modues..."
	@chmod +x scripts/init_package_meta.sh
	@./scripts/init_package_meta.sh

tag-release:
	@echo "Current tags:"
	@git tag -l | sort -V | tail -5
	@echo "Enter new version (e.g., v1.0.0):"
	@read VERSION && git tag $$VERSION && git push origin $$VERSION

install-tools-go:
	@echo "Installing Go protobuf tools..."
	@go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
	@go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest

install-tools-ts:
	@echo "Installing TypeScript protobuf tool..."
	@npm install -g ts-protoc-gen

install-tools: install-tools-go install-tools-ts
	@echo "All tools installed."


help:
	@echo "Available commands:"
	@echo "  make generate        - Generate protobuf files (Go + TS)"
	@echo "  make clean           - Clean generated files"
	@echo "  make build           - Build Go module (ts uses npm)"
	@echo "  make test            - Run tests"
	@echo "  make lint            - Lint proto files"
	@echo "  make check-generated - Check if generated files are up to date"
	@echo "  make tag-release     - Tag a new release"
	@echo "  make install-tools   - Install required tools"
	@echo "  make docker-build    - Build Docker image for proto generation"
	@echo "  make docker-gen      - Generate all protobuf files inside Docker"
	@echo "  make docker-gen-go   - Generate Go protobuf files inside Docker"
	@echo "  make docker-gen-ts   - Generate TypeScript protobuf files inside Docker"
	@echo "  make check-generated-docker - Check generated files inside Docker"

 

# --- New Docker targets --
# Build the protobuf generation Docker image
DOCKER_IMAGE ?= spoungeai/protos-gen
 
docker-build:
	@echo "Building Docker image for protobuf generation..."
	@docker build -t $(DOCKER_IMAGE) .

# Generate Go protobuf files inside Docker container
docker-gen-go:
	@echo "Generating Go protobuf files inside Docker..."
	@docker run --rm -v "$(PWD)":/app -w /app $(DOCKER_IMAGE) make gen-go

# Generate TypeScript protobuf files inside Docker container
docker-gen-ts:
	@echo "Generating TypeScript protobuf files inside Docker..."
	@docker run --rm -v "$(PWD)":/app -w /app $(DOCKER_IMAGE) make gen-ts

# Generate both Go and TypeScript protobuf files inside Docker
docker-gen: docker-gen-go docker-gen-ts
	@echo "✅ Generated Go + TS protobuf files inside Docker"

# Check if generated files are up to date inside Docker
check-generated-docker:
	@echo "Checking if generated files are up to date inside Docker..."
	@docker run --rm -v "$(PWD)":/app -w /app $(DOCKER_IMAGE) make check-generated

# Build image and generate all protobuf files (Go + TS)
docker-setup: docker-build docker-gen
	@echo "🚀 Docker setup complete: image built and protobuf files generated."

fix-permissions:
	@echo "Fixing permissions for generated files and cache..."
	@sudo chown -R $(shell id -u):$(shell id -g) .