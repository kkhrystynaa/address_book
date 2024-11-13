# Variables
PACKAGE_NAME := your_project_name  # Replace with your package name if needed
BIN_NAME := target/debug/$(PACKAGE_NAME)
SRC := $(wildcard src/**/*.rs src/*.rs)  # All Rust source files

# Default target: build the project
all: build

# Build the project in debug mode
build:
	cargo build

# Run the project
run: build
	$(BIN_NAME)

# Run the project in release mode
release:
	cargo build --release
	./target/release/$(PACKAGE_NAME)

# Run tests
test:
	cargo test

# Run clippy for linting
lint:
	cargo clippy -- -D warnings

# Format the code
format:
	cargo fmt --all

# Clean the project
clean:
	cargo clean

# Check formatting and clippy, run tests, and build before committing
precommit: format lint test build

# Help message
help:
	@echo "Makefile commands:"
	@echo "  make build       - Build the project in debug mode"
	@echo "  make run         - Run the project in debug mode"
	@echo "  make release     - Build and run in release mode"
	@echo "  make test        - Run tests"
	@echo "  make lint        - Run Clippy linter"
	@echo "  make format      - Format the code"
	@echo "  make clean       - Clean the build artifacts"
	@echo "  make precommit   - Format, lint, test, and build before committing"
	@echo "  make help        - Show this help message"

# Run `precommit` as the default target when committing.
.PHONY: all build run release test lint format clean precommit help
