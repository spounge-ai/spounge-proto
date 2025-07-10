.PHONY: gen clean

gen:
	@echo "Making generate.sh executable..."
	chmod +x scripts/generate.sh
	@echo "Generating protobuf code..."
	bash scripts/generate.sh

clean:
	@echo "Cleaning generated files..."
	rm -rf gen/go/*
	rm -rf gen/ts/*
