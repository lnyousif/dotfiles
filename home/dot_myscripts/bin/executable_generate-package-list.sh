#!/usr/bin/env bash
# Generate documentation of installed packages

OUTPUT_FILE="$HOME/INSTALLED_PACKAGES.md"

echo "📝 Generating package list..."

cat > "$OUTPUT_FILE" << EOF
# Installed Packages

Generated on: $(date)
Hostname: $(hostname)
OS: $(uname -s) $(uname -r)

---

EOF

# Homebrew packages
if command -v brew &> /dev/null; then
    echo "Collecting Homebrew packages..."
    cat >> "$OUTPUT_FILE" << 'EOF'
## Homebrew Packages

### Formulae
\`\`\`
EOF
    brew list --formula --versions >> "$OUTPUT_FILE" 2>/dev/null || echo "No formulae installed" >> "$OUTPUT_FILE"
    cat >> "$OUTPUT_FILE" << 'EOF'
\`\`\`

### Casks
\`\`\`
EOF
    brew list --cask --versions >> "$OUTPUT_FILE" 2>/dev/null || echo "No casks installed" >> "$OUTPUT_FILE"
    echo '```' >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
fi

# APT packages (Debian/Ubuntu)
if command -v apt &> /dev/null; then
    echo "Collecting APT packages..."
    cat >> "$OUTPUT_FILE" << 'EOF'
## APT Packages

\`\`\`
EOF
    apt list --installed 2>/dev/null | tail -n +2 >> "$OUTPUT_FILE" || echo "Could not list APT packages" >> "$OUTPUT_FILE"
    echo '```' >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
fi

# DNF packages (Fedora/RHEL)
if command -v dnf &> /dev/null; then
    echo "Collecting DNF packages..."
    cat >> "$OUTPUT_FILE" << 'EOF'
## DNF Packages

\`\`\`
EOF
    dnf list installed 2>/dev/null >> "$OUTPUT_FILE" || echo "Could not list DNF packages" >> "$OUTPUT_FILE"
    echo '```' >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
fi

# Pacman packages (Arch)
if command -v pacman &> /dev/null; then
    echo "Collecting Pacman packages..."
    cat >> "$OUTPUT_FILE" << 'EOF'
## Pacman Packages

\`\`\`
EOF
    pacman -Q 2>/dev/null >> "$OUTPUT_FILE" || echo "Could not list Pacman packages" >> "$OUTPUT_FILE"
    echo '```' >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
fi

# NPM global packages
if command -v npm &> /dev/null; then
    echo "Collecting NPM global packages..."
    cat >> "$OUTPUT_FILE" << 'EOF'
## NPM Global Packages

\`\`\`
EOF
    npm list -g --depth=0 2>/dev/null >> "$OUTPUT_FILE" || echo "No global NPM packages" >> "$OUTPUT_FILE"
    echo '```' >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
fi

# Python packages (pip)
if command -v pip3 &> /dev/null; then
    echo "Collecting pip packages..."
    cat >> "$OUTPUT_FILE" << 'EOF'
## Python Packages (pip3)

\`\`\`
EOF
    pip3 list 2>/dev/null >> "$OUTPUT_FILE" || echo "No pip packages" >> "$OUTPUT_FILE"
    echo '```' >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
fi

# Pipx packages
if command -v pipx &> /dev/null; then
    echo "Collecting pipx packages..."
    cat >> "$OUTPUT_FILE" << 'EOF'
## Python Packages (pipx)

\`\`\`
EOF
    pipx list 2>/dev/null >> "$OUTPUT_FILE" || echo "No pipx packages" >> "$OUTPUT_FILE"
    echo '```' >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
fi

# Cargo packages (Rust)
if command -v cargo &> /dev/null; then
    echo "Collecting Cargo packages..."
    cat >> "$OUTPUT_FILE" << 'EOF'
## Rust Packages (Cargo)

\`\`\`
EOF
    cargo install --list 2>/dev/null >> "$OUTPUT_FILE" || echo "No cargo packages" >> "$OUTPUT_FILE"
    echo '```' >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
fi

# VS Code extensions
if command -v code &> /dev/null; then
    echo "Collecting VS Code extensions..."
    cat >> "$OUTPUT_FILE" << 'EOF'
## VS Code Extensions

\`\`\`
EOF
    code --list-extensions --show-versions 2>/dev/null >> "$OUTPUT_FILE" || echo "No VS Code extensions" >> "$OUTPUT_FILE"
    echo '```' >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
fi

echo ""
echo "✅ Package list generated: $OUTPUT_FILE"
echo ""
echo "📊 Quick stats:"
if command -v wc &> /dev/null; then
    line_count=$(wc -l < "$OUTPUT_FILE")
    echo "   Total lines: $line_count"
fi
echo "   File size: $(du -h "$OUTPUT_FILE" | cut -f1)"
