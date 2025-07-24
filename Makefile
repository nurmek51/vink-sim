# FlexTravelSIM Makefile
# Convenient commands for development

.PHONY: help build-dev build-prod clean

# Default target
help:
	@echo "Available commands:"
	@echo "  build-dev    - Build for development"
	@echo "  build-prod   - Build for production"
	@echo "  run-dev      - Run development version"
	@echo "  clean        - Clean build artifacts"
	@echo "  setup        - Initial project setup"

# Building
build-dev:
	@echo "Building for development..."
	flutter build ios --no-codesign

build-prod:
	@echo "Building for production..."
	flutter build ios --release --no-codesign

# Running
run-dev:
	@echo "Running development version..."
	flutter run

# Maintenance
clean:
	@echo "Cleaning build artifacts..."
	flutter clean
	rm -rf build/

setup:
	@echo "Setting up project..."
	flutter pub get
	@echo "Project setup complete!"

# Development helpers
analyze:
	@echo "Running Flutter analyze..."
	flutter analyze

test:
	@echo "Running tests..."
	flutter test

format:
	@echo "Formatting code..."
	dart format .

