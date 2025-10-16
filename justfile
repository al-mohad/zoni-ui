# ZoniUI Package Management Justfile
# Provides commands for development, testing, and publishing to pub.dev

# Default recipe - show available commands
default:
    @just --list

# Development Commands
# ===================

# Install dependencies for all projects
install:
    @echo "📦 Installing dependencies..."
    flutter pub get
    cd example && flutter pub get
    cd widgetbook && flutter pub get
    @echo "✅ Dependencies installed!"

# Clean all build artifacts
clean:
    @echo "🧹 Cleaning build artifacts..."
    flutter clean
    cd example && flutter clean
    cd widgetbook && flutter clean
    rm -rf build/
    rm -rf example/build/
    rm -rf widgetbook/build/
    @echo "✅ Clean complete!"

# Run code analysis
analyze:
    @echo "🔍 Running code analysis..."
    flutter analyze
    @echo "✅ Analysis complete!"

# Format code
format:
    @echo "🎨 Formatting code..."
    dart format lib/ test/ example/lib/ widgetbook/lib/
    @echo "✅ Code formatted!"

# Run all tests
test:
    @echo "🧪 Running tests..."
    flutter test
    @echo "✅ Tests complete!"

# Run tests with coverage
test-coverage:
    @echo "🧪 Running tests with coverage..."
    flutter test --coverage
    @echo "✅ Tests with coverage complete!"

# Generate golden test files
test-golden:
    @echo "🖼️ Generating golden test files..."
    flutter test --update-goldens
    @echo "✅ Golden tests updated!"

# Development workflow - clean, install, analyze, test
dev: clean install analyze test
    @echo "🚀 Development workflow complete!"

# Example App Commands
# ===================

# Run example app on Chrome
example:
    @echo "🌐 Running example app on Chrome..."
    cd example && flutter run -d chrome

# Build example app for web
example-build:
    @echo "🏗️ Building example app for web..."
    cd example && flutter build web
    @echo "✅ Example app built!"

# Widgetbook Commands
# ==================

# Run widgetbook on Chrome
widgetbook:
    @echo "📚 Running widgetbook on Chrome..."
    cd widgetbook && flutter run -d chrome

# Build widgetbook for web
widgetbook-build:
    @echo "🏗️ Building widgetbook for web..."
    cd widgetbook && flutter build web
    @echo "✅ Widgetbook built!"

# Publishing Commands
# ===================

# Pre-publish checks - run all quality checks
pre-publish: clean install analyze test
    @echo "🔍 Running pre-publish checks..."
    @echo "📋 Checking pubspec.yaml..."
    @if [ ! -f "pubspec.yaml" ]; then echo "❌ pubspec.yaml not found!"; exit 1; fi
    @echo "📋 Checking README.md..."
    @if [ ! -f "README.md" ]; then echo "❌ README.md not found!"; exit 1; fi
    @echo "📋 Checking CHANGELOG.md..."
    @if [ ! -f "CHANGELOG.md" ]; then echo "❌ CHANGELOG.md not found!"; exit 1; fi
    @echo "📋 Checking LICENSE..."
    @if [ ! -f "LICENSE" ]; then echo "❌ LICENSE not found!"; exit 1; fi
    @echo "✅ Pre-publish checks passed!"

# Dry run publish - validate package without publishing
publish-dry-run: pre-publish
    @echo "🧪 Running publish dry run..."
    flutter pub publish --dry-run
    @echo "✅ Dry run complete!"

# Validate package for pub.dev
validate: pre-publish
    @echo "✅ Package validation complete!"
    @echo ""
    @echo "📋 Package Summary:"
    @echo "==================="
    @grep "name:" pubspec.yaml
    @grep "version:" pubspec.yaml
    @grep "description:" pubspec.yaml
    @echo ""
    @echo "🔗 Repository URLs:"
    @grep "homepage:" pubspec.yaml
    @grep "repository:" pubspec.yaml
    @echo ""
    @echo "📊 Package Score Prediction:"
    @echo "- ✅ Follows Dart file conventions"
    @echo "- ✅ Provides documentation"
    @echo "- ✅ Supports latest stable Dart/Flutter"
    @echo "- ✅ Has example"
    @echo "- ✅ Has tests"
    @echo ""

# Publish to pub.dev (requires confirmation)
publish: validate publish-dry-run
    @echo "🚀 Ready to publish to pub.dev!"
    @echo ""
    @echo "⚠️  IMPORTANT: This will publish the package to pub.dev"
    @echo "⚠️  Make sure you have:"
    @echo "   - Updated the version in pubspec.yaml"
    @echo "   - Updated CHANGELOG.md"
    @echo "   - Committed all changes to git"
    @echo "   - Tagged the release in git"
    @echo ""
    @read -p "Are you sure you want to publish? (y/N): " confirm && [ "$$confirm" = "y" ]
    @echo "📤 Publishing to pub.dev..."
    flutter pub publish
    @echo "🎉 Package published successfully!"

# Version Management
# ==================

# Show current version
version:
    @echo "📋 Current version:"
    @grep "version:" pubspec.yaml

# Bump patch version (0.1.0 -> 0.1.1)
bump-patch:
    @echo "⬆️ Bumping patch version..."
    @current_version=$$(grep "version:" pubspec.yaml | cut -d' ' -f2); \
    major=$$(echo $$current_version | cut -d'.' -f1); \
    minor=$$(echo $$current_version | cut -d'.' -f2); \
    patch=$$(echo $$current_version | cut -d'.' -f3); \
    new_patch=$$((patch + 1)); \
    new_version="$$major.$$minor.$$new_patch"; \
    sed -i.bak "s/version: $$current_version/version: $$new_version/" pubspec.yaml && rm pubspec.yaml.bak; \
    echo "✅ Version bumped to $$new_version"

# Bump minor version (0.1.0 -> 0.2.0)
bump-minor:
    @echo "⬆️ Bumping minor version..."
    @current_version=$$(grep "version:" pubspec.yaml | cut -d' ' -f2); \
    major=$$(echo $$current_version | cut -d'.' -f1); \
    minor=$$(echo $$current_version | cut -d'.' -f2); \
    new_minor=$$((minor + 1)); \
    new_version="$$major.$$new_minor.0"; \
    sed -i.bak "s/version: $$current_version/version: $$new_version/" pubspec.yaml && rm pubspec.yaml.bak; \
    echo "✅ Version bumped to $$new_version"

# Bump major version (0.1.0 -> 1.0.0)
bump-major:
    @echo "⬆️ Bumping major version..."
    @current_version=$$(grep "version:" pubspec.yaml | cut -d' ' -f2); \
    major=$$(echo $$current_version | cut -d'.' -f1); \
    new_major=$$((major + 1)); \
    new_version="$$new_major.0.0"; \
    sed -i.bak "s/version: $$current_version/version: $$new_version/" pubspec.yaml && rm pubspec.yaml.bak; \
    echo "✅ Version bumped to $$new_version"

# Git Commands
# ============

# Create git tag for current version
tag:
    @version=$$(grep "version:" pubspec.yaml | cut -d' ' -f2); \
    echo "🏷️ Creating git tag v$$version..."; \
    git tag "v$$version"; \
    echo "✅ Tag v$$version created!"

# Push tags to remote
push-tags:
    @echo "📤 Pushing tags to remote..."
    git push --tags
    @echo "✅ Tags pushed!"

# Complete release workflow
release: bump-patch
    @echo "🚀 Starting release workflow..."
    @version=$$(grep "version:" pubspec.yaml | cut -d' ' -f2); \
    echo "📝 Please update CHANGELOG.md for version $$version"; \
    echo "📝 Please commit your changes"; \
    echo "📝 Then run: just tag && just push-tags && just publish"

# Utility Commands
# ===============

# Show package info
info:
    @echo "📦 ZoniUI Package Information"
    @echo "============================="
    @grep "name:" pubspec.yaml
    @grep "version:" pubspec.yaml
    @grep "description:" pubspec.yaml
    @echo ""
    @echo "🔗 Links:"
    @grep "homepage:" pubspec.yaml
    @grep "repository:" pubspec.yaml
    @echo ""
    @echo "📊 Stats:"
    @echo "- Dart files: $$(find lib -name "*.dart" | wc -l | tr -d ' ')"
    @echo "- Test files: $$(find test -name "*.dart" | wc -l | tr -d ' ')"
    @echo "- Example files: $$(find example/lib -name "*.dart" | wc -l | tr -d ' ')"

# Check if package name is available on pub.dev
check-name:
    @echo "🔍 Checking if package name 'zoni_ui' is available on pub.dev..."
    @if curl -s "https://pub.dev/api/packages/zoni_ui" | grep -q "Not Found"; then \
        echo "✅ Package name 'zoni_ui' is available!"; \
    else \
        echo "❌ Package name 'zoni_ui' is already taken!"; \
    fi
