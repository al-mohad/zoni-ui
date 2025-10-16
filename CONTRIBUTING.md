# Contributing to Zoni UI

Thank you for your interest in contributing to Zoni UI! This document provides guidelines and information for contributors.

## Code of Conduct

By participating in this project, you agree to abide by our Code of Conduct. Please read it before contributing.

## Getting Started

### Prerequisites

- Flutter 3.10.0 or higher
- Dart 3.0.0 or higher
- Git

### Setting Up the Development Environment

1. Fork the repository
2. Clone your fork:
   ```bash
   git clone https://github.com/your-username/zoni_ui.git
   cd zoni_ui
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run tests to ensure everything is working:
   ```bash
   flutter test
   ```

## Development Workflow

### Branch Naming

- `feature/description` - for new features
- `fix/description` - for bug fixes
- `docs/description` - for documentation updates
- `refactor/description` - for code refactoring

### Making Changes

1. Create a new branch from `main`:
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. Make your changes following our coding standards

3. Add tests for your changes

4. Run the test suite:
   ```bash
   flutter test
   ```

5. Run golden tests:
   ```bash
   flutter test test/golden/
   ```

6. Check code formatting:
   ```bash
   dart format .
   ```

7. Run static analysis:
   ```bash
   dart analyze
   ```

8. Commit your changes with a descriptive message:
   ```bash
   git commit -m "feat: add new button variant"
   ```

9. Push to your fork:
   ```bash
   git push origin feature/your-feature-name
   ```

10. Create a Pull Request

### Commit Message Format

We follow the [Conventional Commits](https://www.conventionalcommits.org/) specification:

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

Types:
- `feat`: A new feature
- `fix`: A bug fix
- `docs`: Documentation only changes
- `style`: Changes that do not affect the meaning of the code
- `refactor`: A code change that neither fixes a bug nor adds a feature
- `perf`: A code change that improves performance
- `test`: Adding missing tests or correcting existing tests
- `chore`: Changes to the build process or auxiliary tools

Examples:
- `feat(button): add loading state support`
- `fix(card): resolve elevation rendering issue`
- `docs: update README with new examples`

## Coding Standards

### Dart/Flutter Guidelines

- Follow the [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use `dart format` to format your code
- Follow Flutter best practices
- Use meaningful variable and function names
- Add documentation comments for public APIs

### Component Guidelines

When creating new components:

1. **Follow the existing patterns**: Look at existing components for structure and naming conventions

2. **Include comprehensive documentation**: Add dartdoc comments explaining the component's purpose, parameters, and usage

3. **Support accessibility**: Include semantic labels and proper accessibility features

4. **Add debug properties**: Implement `debugFillProperties` for better debugging

5. **Follow Material Design 3**: Ensure components follow Material Design 3 guidelines

6. **Include examples**: Add usage examples in the documentation

### Testing Requirements

All contributions must include appropriate tests:

1. **Unit tests**: For utility functions and business logic
2. **Widget tests**: For component behavior and interaction
3. **Golden tests**: For visual regression testing of components

Test file naming:
- `test/unit/` - Unit tests
- `test/widgets/` - Widget tests  
- `test/golden/` - Golden tests

### Documentation

- Update README.md if adding new features
- Update CHANGELOG.md following the format
- Add dartdoc comments for all public APIs
- Update Widgetbook examples for new components
- Include usage examples in component documentation

## Project Structure

```
lib/
├── src/
│   ├── constants/          # Design tokens and constants
│   ├── theme/             # Theme configuration
│   └── widgets/           # UI components
│       ├── buttons/       # Button components
│       ├── cards/         # Card components
│       ├── inputs/        # Input components
│       └── feedback/      # Feedback components
test/
├── golden/                # Golden tests
├── helpers/               # Test utilities
├── widgets/               # Widget tests
└── unit/                  # Unit tests
example/                   # Example application
widgetbook/               # Widgetbook showcase
```

## Release Process

Releases are handled by maintainers:

1. Update version in `pubspec.yaml`
2. Update `CHANGELOG.md`
3. Create a git tag: `git tag v1.0.0`
4. Push the tag: `git push origin v1.0.0`
5. GitHub Actions will automatically publish to pub.dev

## Getting Help

- Create an issue for bugs or feature requests
- Join our discussions for questions
- Check existing issues and PRs before creating new ones

## Recognition

Contributors will be recognized in our README and release notes. Thank you for helping make Zoni UI better!

## License

By contributing to Zoni UI, you agree that your contributions will be licensed under the MIT License.
