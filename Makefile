.DEFAULT_GOAL := help
MAKEFLAGS += --no-print-directory

# ==============================================================================
# PHONY TARGETS
# ==============================================================================
.PHONY: all generate gen gen-go gen-ts gen-py ts-imports update-py-package \
        chmod-scripts chmod-test-scripts \
        generate-tests test test-go test-ts \
        clean clean-tests \
        lint \
        install-tools install-tools-go install-tools-ts \
        docker-build docker-gen docker-gen-go docker-gen-ts docker-gen-py docker-setup \
        fix-permissions \
        help docker-help

# ==============================================================================
# VARIABLES
# ==============================================================================
# Directories
SCRIPTS_DIR          := scripts
BIN_DIR              := bin # Assuming a 'bin' directory for tools, though not explicitly used for output binaries here

# Docker
DOCKER_IMAGE         ?= spoungeai/protos-gen

# Script definitions
GEN_PB               := $(SCRIPTS_DIR)/generate_pb.sh
GEN_PY               := $(SCRIPTS_DIR)/generate_py.sh
TS_IMPORTS           := $(SCRIPTS_DIR)/ts_imports.sh
BEAUTIFY             := $(SCRIPTS_DIR)/spounge_prettier.sh
UPDATE_PY_PACKAGE    := $(SCRIPTS_DIR)/update_py_package.py
PROTO_SCRIPTS        := $(GEN_PB) $(TS_IMPORTS) $(BEAUTIFY) $(GEN_PY) $(UPDATE_PY_PACKAGE)

GEN_GO_TESTS         := $(SCRIPTS_DIR)/test/generate_go_tests.sh
GEN_TS_TESTS         := $(SCRIPTS_DIR)/test/generate_ts_tests.sh
TEST_SCRIPTS         := $(GEN_GO_TESTS) $(GEN_TS_TESTS)

# Colors
GREEN                := \033[0;32m
YELLOW               := \033[0;33m
CYAN                 := \033[0;36m
RED                  := \033[0;31m
RESET                := \033[0m

# ==============================================================================
# MACROS (Helper Functions)
# ==============================================================================
define make_executable_macro
	@echo "$(CYAN)▶ Making scripts executable: $(1)...$(RESET)"
	@chmod +x $(1)
endef

define docker_run_macro
	@docker run --rm -v "$(PWD)":/app -w /app $(DOCKER_IMAGE) $(1)
endef

define echo_step_macro
	@echo "$(CYAN)▶ $(1)...$(RESET)"
endef

define echo_success_macro
	@echo "$(GREEN)✅ $(1)$(RESET)"
endef

define echo_warning_macro
	@echo "$(YELLOW)⚠️ $(1)$(RESET)"
endef

define echo_error_macro
	@echo "$(RED)❌ $(1)$(RESET)"
endef

define clean_directory_macro
	@echo "$(YELLOW)▶ Cleaning directory: $(1)...$(RESET)"
	@rm -rf $(1)
endef


# ==============================================================================
# COMMANDS
# ==============================================================================

all: generate ## ✨ Default target: Generate all protobuf files

# ------------------------------------------------------------------------------
# Protobuf Generation Commands
# ------------------------------------------------------------------------------
generate: gen ## ✨ Generate all protobuf files (Go, TypeScript, Python)

gen: gen-go gen-ts gen-py ## ✨ Internal: Triggers generation for all languages and updates Python package

chmod-scripts: ## 🔒 Internal: Ensure protobuf generation scripts are executable
	$(call make_executable_macro,$(PROTO_SCRIPTS))

gen-go: chmod-scripts ## ⚙️ Generate Go protobuf files
	$(call echo_step_macro,Generating Go protobuf files)
	@$(GEN_PB) go

gen-ts: chmod-scripts ## ⚙️ Generate TypeScript protobuf files
	$(call echo_step_macro,Generating TypeScript protobuf files)
	@$(GEN_PB) ts
	$(call ts-imports) # Call ts-imports after generation

gen-py: chmod-scripts ## ⚙️ Generate Python protobuf files
	$(call echo_step_macro,Generating Python protobuf files)
	@$(GEN_PY) py

update-py-package: chmod-scripts ## 📦 Update Python package structure for generated protobufs
	$(call echo_step_macro,Updating Python package structure)
	@python3 $(UPDATE_PY_PACKAGE)
	$(call echo_success_macro,Python package structure updated)

ts-imports: chmod-scripts ## ⚙️ Fix TypeScript imports after generation
	$(call echo_step_macro,Fixing TypeScript imports)
	@$(TS_IMPORTS)

# ------------------------------------------------------------------------------
# Testing Commands
# ------------------------------------------------------------------------------
test: generate-tests test-go test-ts ## 🧪 Generate and run all tests (Go and TypeScript)
	$(call echo_success_macro,All tests completed)

chmod-test-scripts: ## 🔒 Internal: Ensure test generation scripts are executable
	$(call make_executable_macro,$(TEST_SCRIPTS))

generate-tests: chmod-test-scripts ## 🧪 Generate test files for Go and TypeScript
	$(call echo_step_macro,Generating test files)
	$(call echo_success_macro,Test files generated)

test-go: ## 🧪 Run Go unit tests
	$(call echo_step_macro,Running Go tests)
	@cd tests/go && go test -v ./...

test-ts: ## 🧪 Run TypeScript unit tests
	$(call echo_step_macro,Running TypeScript tests)
	@cd tests/ts && npm test

# ------------------------------------------------------------------------------
# Cleaning Commands
# ------------------------------------------------------------------------------
clean: clean-gen ## 🧹 Clean all generated files and test files

clean-gen: ## 🧹 Clean all generated protobuf files
	$(call echo_step_macro,Cleaning generated protobuf files)
	$(call clean_directory_macro,gen/go/*)
	$(call clean_directory_macro,gen/ts/*)
	$(call clean_directory_macro,gen/py/*)
	$(call clean_directory_macro,gen/openapi/*)
	$(call echo_success_macro,Generated protobuf files cleaned)

clean-tests: ## 🧹 Clean all generated test files
	$(call echo_step_macro,Cleaning generated test files)
	@find tests/ \( -path tests/go -o -path tests/go/* -o -path tests/ts -o -path tests/ts/* \) -prune -o -type f -delete
	$(call echo_success_macro,Test files cleaned)

# ------------------------------------------------------------------------------
# Linting Commands
# ------------------------------------------------------------------------------
lint: ## 🔎 Lint proto definition files
	$(call echo_step_macro,Linting proto files with buf)
	@buf lint

# ------------------------------------------------------------------------------
# Tool Installation Commands
# ------------------------------------------------------------------------------
install-tools: install-tools-go install-tools-ts ## 📦 Install all required protobuf generation tools

install-tools-go: ## 📦 Install Go protobuf compiler plugins
	$(call echo_step_macro,Installing Go protobuf tools)
	@go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
	@go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
	$(call echo_success_macro,Go protobuf tools installed)

install-tools-ts: ## 📦 Install TypeScript protobuf compiler plugin
	$(call echo_step_macro,Installing TypeScript protobuf tool)
	@npm install -g ts-protoc-gen
	$(call echo_success_macro,TypeScript protobuf tool installed)

# ------------------------------------------------------------------------------
# Docker Commands
# ------------------------------------------------------------------------------
docker-setup: docker-build docker-gen ## 🐳 Build Docker image and generate all protobuf files inside Docker

docker-build: ## 🐳 Build the Docker image for protobuf generation
	$(call echo_step_macro,Building Docker image: $(DOCKER_IMAGE))
	@docker build -t $(DOCKER_IMAGE) .
	$(call echo_success_macro,Docker image built: $(DOCKER_IMAGE))

docker-gen: docker-gen-go docker-gen-ts docker-gen-py ## 🐳 Generate all protobuf files inside Docker
	$(call echo_success_macro,Generated all protobuf files inside Docker)

docker-gen-go: ## 🐳 Generate Go protobuf files inside Docker
	$(call echo_step_macro,Generating Go protobuf files inside Docker)
	$(call docker_run_macro,make gen-go)

docker-gen-ts: ## 🐳 Generate TypeScript protobuf files inside Docker
	$(call echo_step_macro,Installing TS package dependencies and generating files inside Docker)
	$(call docker_run_macro,npm i && make gen-ts)

docker-gen-py: ## 🐳 Generate Python protobuf files inside Docker
	$(call echo_step_macro,Generating Python protobuf files inside Docker)
	$(call docker_run_macro,make gen-py)

# ------------------------------------------------------------------------------
# Utility Commands
# ------------------------------------------------------------------------------
fix-permissions: ## 🔒 Fix permissions for generated files and caches
	$(call echo_step_macro,Fixing permissions for generated files and caches)
	@sudo chown -R $(shell id -u):$(shell id -g) .
	$(call echo_success_macro,Permissions fixed)

# ------------------------------------------------------------------------------
# Help Commands
# ------------------------------------------------------------------------------
help: ## ✨ Show this help message
	@echo "$(CYAN)========================================$(RESET)"
	@echo "$(GREEN)         Protobuf Generation Help       $(RESET)"
	@echo "$(CYAN)========================================$(RESET)"
	@echo ""
	@echo "Usage: make [command]"
	@echo ""
	@echo "$(YELLOW)--- Protobuf Generation Commands ---$(RESET)"
	@grep -E '^(generate|gen-go|gen-ts|gen-py|update-py-package|ts-imports):.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-26s\033[0m %s\n", $$1, $$2}' | \
		sort
	@echo ""
	@echo "$(YELLOW)--- Testing Commands ---$(RESET)"
	@grep -E '^(test|generate-tests|test-go|test-ts):.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-26s\033[0m %s\n", $$1, $$2}' | \
		sort
	@echo ""
	@echo "$(YELLOW)--- Cleaning Commands ---$(RESET)"
	@grep -E '^(clean|clean-gen|clean-tests):.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-26s\033[0m %s\n", $$1, $$2}' | \
		sort
	@echo ""
	@echo "$(YELLOW)--- Linting Commands ---$(RESET)"
	@grep -E '^(lint):.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-26s\033[0m %s\n", $$1, $$2}' | \
		sort
	@echo ""
	@echo "$(YELLOW)--- Tool Installation Commands ---$(RESET)"
	@grep -E '^(install-tools|install-tools-go|install-tools-ts):.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-26s\033[0m %s\n", $$1, $$2}' | \
		sort
	@echo ""
	@echo "$(YELLOW)--- Docker Commands ---$(RESET)"
	@grep -E '^(docker-setup|docker-build|docker-gen|docker-gen-go|docker-gen-ts|docker-gen-py):.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-26s\033[0m %s\n", $$1, $$2}' | \
		sort
	@echo ""
	@echo "$(YELLOW)--- Utility Commands ---$(RESET)"
	@grep -E '^(fix-permissions):.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-26s\033[0m %s\n", $$1, $$2}' | \
		sort
	@echo ""
	@echo "$(YELLOW)--- Help Commands ---$(RESET)"
	@grep -E '^(help):.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-26s\033[0m %s\n", $$1, $$2}' | \
		sort
	@echo "$(CYAN)========================================$(RESET)"