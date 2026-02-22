.PHONY: help pub-get build clean run analyze

help:
	@echo "Available commands:"
	@echo "  make build       - Build the Flutter app"
	@echo "  make clean       - Clean the build artifacts"
	@echo "  make run         - Run the Flutter app on a connected device"
	@echo "  make pub-get     - Get Dart/Flutter dependencies"
	@echo "  make analyze     - Run static analysis"

# Get dependencies
pub-get:
	flutter pub get

# Build the app
build:
	flutter build apk   # For Android
	# flutter build ios # Uncomment if building for iOS

# Clean the build
clean:
	flutter clean

# Run the app
run:
	flutter run

# Analyze code
analyze:
	flutter analyze
