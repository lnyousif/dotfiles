# Contributing to Dotfiles

Thank you for your interest in improving these dotfiles! While this is primarily a personal configuration repository, contributions that improve cross-platform compatibility, documentation, or add useful features are welcome.

## How to Contribute

### 1. Report Issues

Found a bug or have a suggestion?

1. Check existing [issues](https://github.com/lnyousif/dotfiles/issues)
2. Create a new issue with:
   - Clear description
   - Platform/environment details
   - Steps to reproduce (for bugs)
   - Expected vs actual behavior

### 2. Suggest Enhancements

Have an idea for improvement?

1. Open an issue with `enhancement` label
2. Describe the use case
3. Explain why it would be useful
4. Consider cross-platform implications

### 3. Submit Pull Requests

Ready to contribute code?

1. **Fork the repository**
2. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. **Make your changes**
4. **Test on relevant platforms**
5. **Commit with clear messages**
   ```bash
   git commit -m "Add: brief description of what was added"
   ```
6. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```
7. **Open a Pull Request**

## Contribution Guidelines

### Code Style

**Shell Scripts (Bash/Zsh)**
- Use 2-space indentation
- Add comments for complex logic
- Include error handling (`set -e`, `set -u`)
- Make scripts portable (avoid GNU-specific features when possible)
- Use meaningful variable names

**Chezmoi Templates**
- Follow existing template structure
- Use conditional logic for platform differences
- Document template variables
- Test template rendering

**Configuration Files**
- Maintain consistent formatting
- Comment non-obvious settings
- Keep cross-platform compatibility in mind

### Testing

Before submitting, test your changes on:

**For Shell Scripts:**
- [ ] Linux (preferably Ubuntu/Debian)
- [ ] macOS (if applicable)
- [ ] Windows/WSL (if applicable)

**For Templates:**
- [ ] Verify template renders correctly
  ```bash
  chezmoi cat ~/.bashrc
  ```
- [ ] Check for undefined variables
  ```bash
  chezmoi data
  ```

**For Documentation:**
- [ ] Check markdown formatting
- [ ] Verify links work
- [ ] Test code examples

### Commit Messages

Use clear, descriptive commit messages:

**Format:**
```
Type: Brief description (50 chars or less)

Detailed explanation if needed (wrap at 72 characters)

Fixes #123 (if applicable)
```

**Types:**
- `Add:` - New feature or file
- `Fix:` - Bug fix
- `Update:` - Modify existing feature
- `Refactor:` - Code restructuring
- `Docs:` - Documentation changes
- `Style:` - Formatting, no code change
- `Test:` - Adding or updating tests

**Examples:**
```
Add: Python devcontainer template

Create a complete Python development container template with
common tools and extensions for data science workflows.

Docs: Update troubleshooting guide

Add section on resolving package manager issues across different
Linux distributions.

Fix: Typo in linux-install.sh script

Remove extra 'y' character from echo statement.
```

## What to Contribute

### Welcome Contributions

✅ **Documentation improvements**
- Clearer explanations
- Additional examples
- Troubleshooting tips
- Platform-specific notes

✅ **Bug fixes**
- Cross-platform issues
- Installation problems
- Configuration errors
- Template syntax errors

✅ **DevContainer templates**
- Additional language templates
- Framework-specific configs
- Tool combinations

✅ **Package additions**
- Useful development tools
- Cross-platform utilities
- Well-maintained projects

✅ **Script improvements**
- Better error handling
- Performance optimizations
- Compatibility fixes

### Think Twice Before Contributing

⚠️ **Personal preferences**
- Editor keybindings
- Color schemes
- Highly subjective settings

⚠️ **Breaking changes**
- Removing existing features
- Changing core behavior
- Incompatible modifications

⚠️ **Large refactors**
- Discuss in an issue first
- Consider backward compatibility
- Provide migration guide

## Platform Considerations

When contributing, consider:

### Linux
- Multiple distributions (Debian, Fedora, Arch, Alpine)
- Different package managers
- Various desktop environments
- Both GUI and headless systems

### macOS
- Intel vs Apple Silicon
- Different macOS versions
- Homebrew dependencies
- System Integrity Protection

### Windows
- PowerShell 5.1 vs 7+
- WSL vs native Windows
- Winget availability
- Path separator differences

### Containers
- Limited tool availability
- Ephemeral nature
- User permissions
- Network restrictions

## Documentation Standards

### Markdown Files

- Use proper heading hierarchy
- Include code blocks with language tags
- Add tables for structured data
- Link to related documentation

### Code Examples

Always include:
```bash
# What the command does
command --with-flags

# Expected output
Output example here
```

### File Paths

Use platform-appropriate examples:
```bash
# Linux/macOS
~/.config/app/config.json

# Windows
%APPDATA%\app\config.json
```

## Pull Request Process

1. **Update documentation** if needed
2. **Ensure commits are clean** (squash if necessary)
3. **Fill out PR template** with:
   - Description of changes
   - Motivation and context
   - Testing performed
   - Screenshots (for UI changes)
4. **Wait for review** - may take a few days
5. **Address feedback** promptly
6. **Celebrate** when merged! 🎉

## Questions?

- Open a [discussion](https://github.com/lnyousif/dotfiles/discussions)
- Comment on related issues
- Check existing documentation

## Code of Conduct

### Our Standards

- Be respectful and inclusive
- Welcome diverse perspectives
- Focus on what's best for the project
- Show empathy toward others
- Accept constructive criticism gracefully

### Unacceptable Behavior

- Harassment or discrimination
- Trolling or insulting comments
- Publishing others' private information
- Other unprofessional conduct

## License

By contributing, you agree that your contributions will be licensed under the same license as the project (if any).

## Recognition

Contributors will be:
- Acknowledged in commit messages
- Listed in release notes (for significant contributions)
- Appreciated for their time and effort! 🙏

## Getting Started

Ready to contribute?

1. **Fork the repo**
   ```bash
   gh repo fork lnyousif/dotfiles --clone
   ```

2. **Make your changes**
   ```bash
   cd dotfiles
   git checkout -b feature/my-improvement
   # Make changes
   ```

3. **Test locally**
   ```bash
   ./bootstrap.sh  # Or platform-specific install
   ```

4. **Commit and push**
   ```bash
   git commit -am "Add: my improvement"
   git push origin feature/my-improvement
   ```

5. **Create PR**
   ```bash
   gh pr create --fill
   ```

## Resources

- [Chezmoi Documentation](https://www.chezmoi.io/)
- [DevContainers Spec](https://containers.dev/)
- [Bash Scripting Guide](https://www.gnu.org/software/bash/manual/)
- [GitHub Flow](https://guides.github.com/introduction/flow/)

Thank you for contributing! 🚀
