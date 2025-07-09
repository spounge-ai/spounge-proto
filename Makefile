.PHONY: generate-buf all help

# Default target (for now)
all: generate-buf

# Generate buf.yaml from proto scripts
generate-buf:
	@chmod +x ./scripts/construct_buf_yaml.sh
	@echo "Generating buf.yaml..."
	@bash ./scripts/construct_buf_yaml.sh
	@echo "Done!"

# Help target to list available commands
help:
	@echo "Available targets:"
	@echo "  make generate-buf           Generate buf.yaml"
	@echo "  make all                   Default: generate-buf"
