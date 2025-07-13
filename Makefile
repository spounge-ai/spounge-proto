.PHONY: generate clean build test gen gen-go gen-ts lint install-tools help \
       docker-build docker-gen-go docker-gen-ts docker-gen check-generated-docker chmod-scripts fix-permissions \
       generate-tests test-go test-ts clean-tests

# --- Configuration ---
SCRIPTS_DIR := scripts
DOCKER_IMAGE ?= spoungeai/protos-gen

# --- Script definitions ---
GEN_PB := $(SCRIPTS_DIR)/generate_pb.sh
TS_IMPORTS := $(SCRIPTS_DIR)/ts_imports.sh
BEAUTIFY := $(SCRIPTS_DIR)/spounge_prettier.sh
PROTO_SCRIPTS := $(GEN_PB) $(TS_IMPORTS) $(BEAUTIFY)

GEN_GO_TESTS := $(SCRIPTS_DIR)/generate_go_tests.sh
GEN_TS_TESTS := $(SCRIPTS_DIR)/generate_ts_tests.sh
TEST_SCRIPTS := $(GEN_GO_TESTS) $(GEN_TS_TESTS)

# --- Helper functions ---
define make_executable
	@echo "Making scripts executable..."
	@chmod +x $(1)
endef

define docker_run
	@docker run --rm -v "$(PWD)":/app -w /app $(DOCKER_IMAGE) $(1)
endef

define echo_step
	@echo "$(1)..."
endef

define clean_directory
	@rm -rf $(1)
endef

# --- Main targets ---
generate: gen

gen: gen-go gen-ts

# --- Protobuf generation ---
chmod-scripts:
	$(call make_executable,$(PROTO_SCRIPTS))

gen-go: chmod-scripts
	$(call echo_step,Generating Go protobuf files)
	@$(GEN_PB) go

gen-ts: chmod-scripts
	$(call echo_step,Generating TypeScript protobuf files)
	@$(GEN_PB) ts

ts-imports: chmod-scripts
	$(call echo_step,Getting TypeScript imports)
	@$(TS_IMPORTS)

# --- Test generation and execution ---
chmod-test-scripts:
	$(call make_executable,$(TEST_SCRIPTS))

generate-tests: chmod-test-scripts
	$(call echo_step,Generating test files)
	@$(GEN_GO_TESTS)
	@$(GEN_TS_TESTS)

test-go:
	$(call echo_step,Running Go tests)
	@cd tests/go && go test -v ./...

test-ts:
	$(call echo_step,Running TypeScript tests)
	@cd tests/ts && npm test


test:
	@echo "Running tests... (porting over to microservices to test)"
	@echo "[!] @Evantopian: In the works"

# --- Cleanup ---
clean:
	$(call echo_step,Cleaning generated files)
	$(call clean_directory,gen/go/*)
	$(call clean_directory,gen/ts/*)

clean-tests:
	$(call echo_step,Cleaning test files)
	@find tests/ \( -path tests/go -o -path tests/go/* -o -path tests/ts -o -path tests/ts/* \) -prune -o -type f -delete

# --- Linting ---
lint:
	$(call echo_step,Linting proto files)
	@buf lint

# --- Tool installation ---
install-tools-go:
	$(call echo_step,Installing Go protobuf tools)
	@go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
	@go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest

install-tools-ts:
	$(call echo_step,Installing TypeScript protobuf tool)
	@npm install -g ts-protoc-gen

install-tools: install-tools-go install-tools-ts
	$(call echo_step,All tools installed)

# --- Docker targets ---
docker-build:
	$(call echo_step,Building Docker image for protobuf generation)
	@docker build -t $(DOCKER_IMAGE) .

docker-gen-go:
	$(call echo_step,Generating Go protobuf files inside Docker)
	$(call docker_run,make gen-go)

docker-gen-ts:
	$(call echo_step,Generating TypeScript protobuf files inside Docker)
	$(call docker_run,npm i)
	$(call echo_step,Installing TS package dependencies)
	$(call docker_run,make gen-ts)

docker-gen: docker-gen-go docker-gen-ts
	$(call echo_step,✅ Generated Go + TS protobuf files inside Docker)

docker-setup: docker-build docker-gen
	$(call echo_step,🚀 Docker setup complete: image built and protobuf files generated)

# --- Permissions ---
fix-permissions:
	$(call echo_step,Fixing permissions for generated files and cache)
	@sudo chown -R $(shell id -u):$(shell id -g) .

# --- Help ---
help:
	@echo "Available commands:"
	@echo "  make generate        - Generate protobuf files (Go + TS)"
	@echo "  make generate-tests  - Generate test files"
	@echo "  make test            - Generate and run all tests"
	@echo "  make test-go         - Run Go tests only"
	@echo "  make test-ts         - Run TypeScript tests only"
	@echo "  make clean           - Clean generated files"
	@echo "  make clean-tests     - Clean test files"
	@echo "  make lint            - Lint proto files"
	@echo "  make install-tools   - Install required tools"
	@echo "  make docker-build    - Build Docker image for proto generation"
	@echo "  make docker-gen      - Generate all protobuf files inside Docker"
	@echo "  make docker-gen-go   - Generate Go protobuf files inside Docker"
	@echo "  make docker-gen-ts   - Generate TypeScript protobuf files inside Docker"
	@echo "  make check-generated-docker - Check generated files inside Docker"