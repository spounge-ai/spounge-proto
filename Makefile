.PHONY: generate clean build test gen gen-go gen-ts lint install-tools help \
        docker-build docker-gen-go docker-gen-ts docker-gen check-generated-docker chmod-scripts fix-permissions

SCRIPTS_DIR := scripts
GEN_PB := $(SCRIPTS_DIR)/generate_pb.sh
TS_IMPORTS := $(SCRIPTS_DIR)/ts_imports.sh
BEAUTIFY := $(SCRIPTS_DIR)/spounge_prettier.sh

# --- Existing targets ---

generate: gen

gen: gen-go gen-ts

chmod-scripts:
	@chmod +x $$(BEAUTIFY) $(GEN_PB) $(TS_IMPORTS) 

gen-go: chmod-scripts
	@echo "Generating Go protobuf files..."
	@./$(GEN_PB) go

gen-ts: chmod-scripts
	@echo "Generating TypeScript protobuf files..."
	@./$(GEN_PB) ts

ts-imports: chmod-scripts
	@echo "Getting TypeScript imports..."
	@./$(TS_IMPORTS)

clean:
	@echo "Cleaning generated files..."
	@rm -rf gen/go/*
	@rm -rf gen/ts/*

test:
	@echo "Running tests..."
	@echo "[!] @Evantopian: In the works"

lint:
	@echo "Linting proto files..."
	@buf lint

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
	@echo "  make test            - Run tests"
	@echo "  make lint            - Lint proto files"
	@echo "  make install-tools   - Install required tools"
	@echo "  make docker-build    - Build Docker image for proto generation"
	@echo "  make docker-gen      - Generate all protobuf files inside Docker"
	@echo "  make docker-gen-go   - Generate Go protobuf files inside Docker"
	@echo "  make docker-gen-ts   - Generate TypeScript protobuf files inside Docker"
	@echo "  make check-generated-docker - Check generated files inside Docker"




# --- New Docker targets ---

DOCKER_IMAGE ?= spoungeai/protos-gen

docker-build:
	@echo "Building Docker image for protobuf generation..."
	@docker build -t $(DOCKER_IMAGE) .

docker-gen-go:
	@echo "Generating Go protobuf files inside Docker..."
	@docker run --rm -v "$(PWD)":/app -w /app $(DOCKER_IMAGE) make gen-go

docker-gen-ts:
	@echo "Generating TypeScript protobuf files inside Docker..."
	@docker run --rm -v "$(PWD)":/app -w /app $(DOCKER_IMAGE) npm i
	@echo "Installing TS package dependencies...."
	@docker run --rm -v "$(PWD)":/app -w /app $(DOCKER_IMAGE) make gen-ts

docker-gen: docker-gen-go docker-gen-ts
	@echo "✅ Generated Go + TS protobuf files inside Docker"

docker-setup: docker-build docker-gen
	@echo "🚀 Docker setup complete: image built and protobuf files generated."

fix-permissions:
	@echo "Fixing permissions for generated files and cache..."
	@sudo chown -R $(shell id -u):$(shell id -g) .
