#!/usr/bin/env bash
# System health check for dotfiles setup

set -e

GREEN="\033[0;32m"
RED="\033[0;31m"
YELLOW="\033[0;33m"
BLUE="\033[0;34m"
NC="\033[0m"

echo -e "${BLUE}=== System Health Check ===${NC}\n"

# Check essential tools
echo -e "${BLUE}Checking essential tools:${NC}"
TOOLS=("git" "chezmoi" "starship" "micro" "tmux")
for tool in "${TOOLS[@]}"; do
    if command -v "$tool" &> /dev/null; then
        version=$(command "$tool" --version 2>&1 | head -n1 || echo "")
        echo -e "${GREEN}OK${NC} $tool ${YELLOW}($version)${NC}"
    else
        echo -e "${RED}MISSING${NC} $tool (missing)"
    fi
done

# Check optional modern CLI tools
echo -e "\n${BLUE}Checking optional CLI tools:${NC}"
OPTIONAL_TOOLS=("fzf" "ripgrep" "fd" "bat" "exa" "zoxide" "delta" "btop" "duf" "dust")
for tool in "${OPTIONAL_TOOLS[@]}"; do
    if command -v "$tool" &> /dev/null; then
        echo -e "${GREEN}OK${NC} $tool"
    else
        echo -e "${YELLOW}OPTIONAL${NC} $tool (optional, not installed)"
    fi
done

# Check shell configuration files
echo -e "\n${BLUE}Checking shell configuration:${NC}"
CONFIGS=("$HOME/.bashrc" "$HOME/.zshrc" "$HOME/.bash_aliases" "$HOME/.myscripts/bash_functions")
for config in "${CONFIGS[@]}"; do
    if [ -f "$config" ]; then
        echo -e "${GREEN}OK${NC} $(basename $config)"
    else
        echo -e "${YELLOW}OPTIONAL${NC} $(basename $config) (not found)"
    fi
done

# Check Git configuration
echo -e "\n${BLUE}Checking Git configuration:${NC}"
if command -v git &> /dev/null; then
    git_user=$(git config --global user.name 2>/dev/null || echo "Not set")
    git_email=$(git config --global user.email 2>/dev/null || echo "Not set")
    git_gpg=$(git config --global commit.gpgsign 2>/dev/null || echo "false")

    echo -e "  User: ${YELLOW}$git_user${NC}"
    echo -e "  Email: ${YELLOW}$git_email${NC}"
    echo -e "  GPG signing: ${YELLOW}$git_gpg${NC}"
fi

# Check PATH analysis
echo -e "\n${BLUE}PATH directories (first 10):${NC}"
echo "$PATH" | tr ':' '\n' | head -10 | nl -w2 -s'. '

# Check for duplicate PATH entries
duplicate_count=$(echo "$PATH" | tr ':' '\n' | sort | uniq -d | wc -l)
if [ "$duplicate_count" -gt 0 ]; then
    echo -e "\n${YELLOW}WARNING: Found $duplicate_count duplicate PATH entries${NC}"
else
    echo -e "\n${GREEN}No duplicate PATH entries${NC}"
fi

# System info
echo -e "\n${BLUE}=== System Information ===${NC}"
echo -e "  OS: ${YELLOW}$(uname -s)${NC}"
echo -e "  Kernel: ${YELLOW}$(uname -r)${NC}"
echo -e "  Architecture: ${YELLOW}$(uname -m)${NC}"
if [ -f /etc/os-release ]; then
    . /etc/os-release
    echo -e "  Distribution: ${YELLOW}$PRETTY_NAME${NC}"
fi

echo -e "\n${GREEN}Health check complete!${NC}"
